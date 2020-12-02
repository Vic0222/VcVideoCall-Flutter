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
  static final _$sendCallOffer =
      $grpc.ClientMethod<$0.CallOfferRequest, $0.CallOfferResponse>(
          '/chat.Chat/SendCallOffer',
          ($0.CallOfferRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CallOfferResponse.fromBuffer(value));
  static final _$sendCallAnswer =
      $grpc.ClientMethod<$0.CallAnswerRequest, $0.CallAnswerResponse>(
          '/chat.Chat/SendCallAnswer',
          ($0.CallAnswerRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CallAnswerResponse.fromBuffer(value));
  static final _$sendIceCandidate =
      $grpc.ClientMethod<$0.IceCandidateRequest, $0.IceCandidateResponse>(
          '/chat.Chat/SendIceCandidate',
          ($0.IceCandidateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.IceCandidateResponse.fromBuffer(value));
  static final _$sendPeerConnectionClose = $grpc.ClientMethod<
          $0.PeerConnectionCloseRequest, $0.PeerConnectionCloseResponse>(
      '/chat.Chat/SendPeerConnectionClose',
      ($0.PeerConnectionCloseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PeerConnectionCloseResponse.fromBuffer(value));

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

  $grpc.ResponseFuture<$0.CallOfferResponse> sendCallOffer(
      $0.CallOfferRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$sendCallOffer, request, options: options);
  }

  $grpc.ResponseFuture<$0.CallAnswerResponse> sendCallAnswer(
      $0.CallAnswerRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$sendCallAnswer, request, options: options);
  }

  $grpc.ResponseFuture<$0.IceCandidateResponse> sendIceCandidate(
      $0.IceCandidateRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$sendIceCandidate, request, options: options);
  }

  $grpc.ResponseFuture<$0.PeerConnectionCloseResponse> sendPeerConnectionClose(
      $0.PeerConnectionCloseRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$sendPeerConnectionClose, request,
        options: options);
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
    $addMethod($grpc.ServiceMethod<$0.CallOfferRequest, $0.CallOfferResponse>(
        'SendCallOffer',
        sendCallOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CallOfferRequest.fromBuffer(value),
        ($0.CallOfferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CallAnswerRequest, $0.CallAnswerResponse>(
        'SendCallAnswer',
        sendCallAnswer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CallAnswerRequest.fromBuffer(value),
        ($0.CallAnswerResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.IceCandidateRequest, $0.IceCandidateResponse>(
            'SendIceCandidate',
            sendIceCandidate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.IceCandidateRequest.fromBuffer(value),
            ($0.IceCandidateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PeerConnectionCloseRequest,
            $0.PeerConnectionCloseResponse>(
        'SendPeerConnectionClose',
        sendPeerConnectionClose_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PeerConnectionCloseRequest.fromBuffer(value),
        ($0.PeerConnectionCloseResponse value) => value.writeToBuffer()));
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

  $async.Future<$0.CallOfferResponse> sendCallOffer_Pre($grpc.ServiceCall call,
      $async.Future<$0.CallOfferRequest> request) async {
    return sendCallOffer(call, await request);
  }

  $async.Future<$0.CallAnswerResponse> sendCallAnswer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CallAnswerRequest> request) async {
    return sendCallAnswer(call, await request);
  }

  $async.Future<$0.IceCandidateResponse> sendIceCandidate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.IceCandidateRequest> request) async {
    return sendIceCandidate(call, await request);
  }

  $async.Future<$0.PeerConnectionCloseResponse> sendPeerConnectionClose_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PeerConnectionCloseRequest> request) async {
    return sendPeerConnectionClose(call, await request);
  }

  $async.Stream<$0.JoinResponse> join(
      $grpc.ServiceCall call, $0.JoinRequest request);
  $async.Future<$0.GetRoomsResponse> getRooms(
      $grpc.ServiceCall call, $0.GetRoomsRequest request);
  $async.Future<$0.GetMessagesResponse> getMessages(
      $grpc.ServiceCall call, $0.GetMessagesRequest request);
  $async.Future<$0.MessageResponse> sendMessageRequest(
      $grpc.ServiceCall call, $0.MessageRequest request);
  $async.Future<$0.CallOfferResponse> sendCallOffer(
      $grpc.ServiceCall call, $0.CallOfferRequest request);
  $async.Future<$0.CallAnswerResponse> sendCallAnswer(
      $grpc.ServiceCall call, $0.CallAnswerRequest request);
  $async.Future<$0.IceCandidateResponse> sendIceCandidate(
      $grpc.ServiceCall call, $0.IceCandidateRequest request);
  $async.Future<$0.PeerConnectionCloseResponse> sendPeerConnectionClose(
      $grpc.ServiceCall call, $0.PeerConnectionCloseRequest request);
}
