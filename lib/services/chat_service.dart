import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:vc_video_call/grpc/generated/chat.pbgrpc.dart';
import 'package:vc_video_call/grpc/interceptors/auth_client_interceptor.dart';
import 'package:vc_video_call/services/authentication_service.dart';
import 'dart:developer';
import 'package:fixnum/fixnum.dart';

//should use resilience and transient-fault-handling like .net polly
class ChatService {
  static ChatService _instance;

  StreamSubscription<JoinResponse> _responseStream;

  factory ChatService(
      AuthenticationService authenticationService, String host, int port) {
    if (_instance == null) {
      _instance = ChatService._(authenticationService, host, port);
    }
    return _instance;
  }
  final AuthenticationService authenticationService;

  ChatClient _client;
  final String _host;
  final int _port;
  bool _connected = false;

  ChatService._(this.authenticationService, this._host, this._port) {
    final channel = ClientChannel(
      _host,
      port: _port,
      options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          connectionTimeout: Duration(seconds: 5)),
    );

    _client = ChatClient(channel, interceptors: [
      AuthClientInterceptor(authenticationService),
    ]);
  }

  final StreamController<JoinResponse> joinResponseController =
      StreamController<JoinResponse>.broadcast();

  final StreamController<String> errorStreamController =
      StreamController<String>.broadcast();

  Future join({
    bool force = false,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    if (!_connected || force) {
      _responseStream?.cancel();

      var joinRequest = JoinRequest();

      _responseStream = _client.join(joinRequest).listen(
        (joinReply) {
          joinResponseController.add(joinReply);
          _connected = true;
        },
        onDone: () {
          log("join done");
        },
        onError: (error) {
          _connected = false;
          errorStreamController.add(error.toString());
          log(error.toString(), error: error);
        },
        cancelOnError: true,
      );

      //manual timout checker
      DateTime starTime = DateTime.now();

      await Future.doWhile(() async {
        await Future.delayed(Duration(seconds: 1));
        DateTime currentTime = DateTime.now();
        return !_connected && (currentTime.difference(starTime) < timeout);
      });

      if (!_connected) {
        errorStreamController.add("Connection timedout");
      }
    }
  }

  Future<GetRoomsResponse> getRooms() async {
    return await _client
        .getRooms(GetRoomsRequest())
        .then((roomListReply) => roomListReply);
  }

  Future<GetMessagesResponse> getMessages(
      String roomId, Int64 timestamp) async {
    var getMessageRequest = GetMessagesRequest();
    getMessageRequest.roomId = roomId;
    getMessageRequest.lastMessageDatetime = timestamp;

    return await _client.getMessages(getMessageRequest);
  }

  Future disconnect() async {
    await _responseStream.cancel();
  }

  Future sendMessage(String roomId, String message) async {
    var messageRequest = MessageRequest();
    messageRequest.roomId = roomId;
    messageRequest.messageBody = message;

    await _client.sendMessageRequest(messageRequest);
  }
}
