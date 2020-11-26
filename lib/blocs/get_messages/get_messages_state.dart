import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

enum GetMessagesStatus { initial, inProgress, success, failure }

class GetMessagesState extends Equatable {
  final GetMessagesStatus status;
  final String errorMessage;
  final GetMessagesResponse getMessagesResponse;
  final String userId;

  const GetMessagesState._({
    this.status = GetMessagesStatus.initial,
    this.errorMessage = "",
    this.getMessagesResponse,
    this.userId,
  });

  GetMessagesState.initial() : this._();

  GetMessagesState.inProgress() : this._(status: GetMessagesStatus.inProgress);

  GetMessagesState.success(
      GetMessagesResponse getMessagesResponse, String userId)
      : this._(
          status: GetMessagesStatus.success,
          getMessagesResponse: getMessagesResponse,
          userId: userId,
        );

  GetMessagesState.failure(String errorMessage)
      : this._(status: GetMessagesStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage, getMessagesResponse, userId];
}
