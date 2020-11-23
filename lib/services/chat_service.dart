import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:vc_video_call/grpc/generated/chat.pbgrpc.dart';
import 'package:vc_video_call/services/authentication_service.dart';
import 'dart:developer';

//should use resilience and transient-fault-handling like .net polly
class ChatService {
  static ChatService _instance;
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
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _client = ChatClient(channel);
  }

  final StreamController<MessageRequest> messageRequestsController =
      StreamController<MessageRequest>();

  final StreamController<Notification> notificationStreamController =
      StreamController<Notification>();

  Future tryJoin({int maxRetry = 5}) async {
    int retry = 0;

    while (!_connected && retry <= maxRetry) {
      try {
        log("joining chat service");
        await join();
        log("join success");
        _connected = true;
      } catch (e) {
        log(e.toString());
        retry++;
        log("joining chat service failed. retries :" + retry.toString());
        if (retry > maxRetry) {
          throw e;
        }
      }
    }
  }

  Future join() async {
    _client.join(messageRequestsController.stream).listen(
      (notification) {
        notificationStreamController.add(notification);
      },
      onError: (error) {
        _connected = false;
        log(error);
        tryJoin();
      },
      cancelOnError: true,
    );
  }

  void disconnect() {
    messageRequestsController.close();
  }
}
