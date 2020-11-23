///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;
export 'chat.pb.dart';

class ChatClient extends $grpc.Client {
  static final _$join = $grpc.ClientMethod<$0.MessageRequest, $0.Notification>(
      '/chat.Chat/Join',
      ($0.MessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Notification.fromBuffer(value));
  static final _$getRooms =
      $grpc.ClientMethod<$0.RoomRequest, $0.RoomListReply>(
          '/chat.Chat/GetRooms',
          ($0.RoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.RoomListReply.fromBuffer(value));

  ChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Notification> join(
      $async.Stream<$0.MessageRequest> request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(_$join, request, options: options);
  }

  $grpc.ResponseFuture<$0.RoomListReply> getRooms($0.RoomRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getRooms, request, options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'chat.Chat';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.MessageRequest, $0.Notification>(
        'Join',
        join,
        true,
        true,
        ($core.List<$core.int> value) => $0.MessageRequest.fromBuffer(value),
        ($0.Notification value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RoomRequest, $0.RoomListReply>(
        'GetRooms',
        getRooms_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RoomRequest.fromBuffer(value),
        ($0.RoomListReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.RoomListReply> getRooms_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RoomRequest> request) async {
    return getRooms(call, await request);
  }

  $async.Stream<$0.Notification> join(
      $grpc.ServiceCall call, $async.Stream<$0.MessageRequest> request);
  $async.Future<$0.RoomListReply> getRooms(
      $grpc.ServiceCall call, $0.RoomRequest request);
}
