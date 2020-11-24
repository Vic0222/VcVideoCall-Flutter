import 'dart:io';

import 'package:grpc/service_api.dart';
import 'package:vc_video_call/services/authentication_service.dart';
import 'dart:async';

class AuthClientInterceptor extends ClientInterceptor {
  AuthClientInterceptor(this._authenticationService);
  final AuthenticationService _authenticationService;
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    options = options.mergedWith(
      CallOptions(providers: [
        addUserToken,
      ]),
    );
    return super.interceptStreaming(method, requests, options, invoker);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    options = options.mergedWith(
      CallOptions(providers: [
        addUserToken,
      ]),
    );
    return super.interceptUnary(method, request, options, invoker);
  }

  FutureOr<void> addUserToken(Map<String, String> metaData, String uri) async {
    metaData["Authorization"] =
        "Bearer " + await _authenticationService.getToken();
  }
}
