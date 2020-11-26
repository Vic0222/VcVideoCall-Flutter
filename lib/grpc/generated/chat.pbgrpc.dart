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
  static final _$join = $grpc.ClientMethod<$0.JoinRequest, $0.JoinResponse>(
      '/chat.Chat/Join',
      ($0.JoinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.JoinResponse.fromBuffer(value));
  static final _$getRooms =
      $grpc.ClientMethod<$0.GetRoomsRequest, $0.GetRoomsResponse>(
          '/chat.Chat/GetRooms',
          ($0.GetRoomsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetRoomsResponse.fromBuffer(value));
  static final _$getMessages =
      $grpc.ClientMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
          '/chat.Chat/GetMessages',
          ($0.GetMessagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetMessagesResponse.fromBuffer(value));
  static final _$sendMessageRequest =
      $grpc.ClientMethod<$0.MessageRequest, $0.MessageResponse>(
          '/chat.Chat/SendMessageRequest',
          ($0.MessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MessageResponse.fromBuffer(value));

  ChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.JoinResponse> join($0.JoinRequest request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(_$join, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.GetRoomsResponse> getRooms($0.GetRoomsRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getRooms, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMessagesResponse> getMessages(
      $0.GetMessagesRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getMessages, request, options: options);
  }

  $grpc.ResponseFuture<$0.MessageResponse> sendMessageRequest(
      $0.MessageRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$sendMessageRequest, request, options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'chat.Chat';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.JoinRequest, $0.JoinResponse>(
        'Join',
        join_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.JoinRequest.fromBuffer(value),
        ($0.JoinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRoomsRequest, $0.GetRoomsResponse>(
        'GetRooms',
        getRooms_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRoomsRequest.fromBuffer(value),
        ($0.GetRoomsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
            'GetMessages',
            getMessages_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetMessagesRequest.fromBuffer(value),
            ($0.GetMessagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MessageRequest, $0.MessageResponse>(
        'SendMessageRequest',
        sendMessageRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessageRequest.fromBuffer(value),
        ($0.MessageResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.JoinResponse> join_Pre(
      $grpc.ServiceCall call, $async.Future<$0.JoinRequest> request) async* {
    yield* join(call, await request);
  }

  $async.Future<$0.GetRoomsResponse> getRooms_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetRoomsRequest> request) async {
    return getRooms(call, await request);
  }

  $async.Future<$0.GetMessagesResponse> getMessages_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetMessagesRequest> request) async {
    return getMessages(call, await request);
  }

  $async.Future<$0.MessageResponse> sendMessageRequest_Pre(
      $grpc.ServiceCall call, $async.Future<$0.MessageRequest> request) async {
    return sendMessageRequest(call, await request);
  }

  $async.Stream<$0.JoinResponse> join(
      $grpc.ServiceCall call, $0.JoinRequest request);
  $async.Future<$0.GetRoomsResponse> getRooms(
      $grpc.ServiceCall call, $0.GetRoomsRequest request);
  $async.Future<$0.GetMessagesResponse> getMessages(
      $grpc.ServiceCall call, $0.GetMessagesRequest request);
  $async.Future<$0.MessageResponse> sendMessageRequest(
      $grpc.ServiceCall call, $0.MessageRequest request);
}
