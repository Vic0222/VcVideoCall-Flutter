///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class JoinResponseType extends $pb.ProtobufEnum {
  static const JoinResponseType Confirmation = JoinResponseType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Confirmation');
  static const JoinResponseType Notification = JoinResponseType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Notification');
  static const JoinResponseType CallSignaling = JoinResponseType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CallSignaling');
  static const JoinResponseType IceCandidate = JoinResponseType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IceCandidate');
  static const JoinResponseType PeerConnectionClose = JoinResponseType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PeerConnectionClose');

  static const $core.List<JoinResponseType> values = <JoinResponseType> [
    Confirmation,
    Notification,
    CallSignaling,
    IceCandidate,
    PeerConnectionClose,
  ];

  static final $core.Map<$core.int, JoinResponseType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static JoinResponseType valueOf($core.int value) => _byValue[value];

  const JoinResponseType._($core.int v, $core.String n) : super(v, n);
}

class CallOfferStatus extends $pb.ProtobufEnum {
  static const CallOfferStatus CallOfferRejected = CallOfferStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CallOfferRejected');
  static const CallOfferStatus CallOfferAccepted = CallOfferStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CallOfferAccepted');

  static const $core.List<CallOfferStatus> values = <CallOfferStatus> [
    CallOfferRejected,
    CallOfferAccepted,
  ];

  static final $core.Map<$core.int, CallOfferStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CallOfferStatus valueOf($core.int value) => _byValue[value];

  const CallOfferStatus._($core.int v, $core.String n) : super(v, n);
}

class CallSignalType extends $pb.ProtobufEnum {
  static const CallSignalType CallSignalOffer = CallSignalType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CallSignalOffer');
  static const CallSignalType CallSignalAnswer = CallSignalType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CallSignalAnswer');

  static const $core.List<CallSignalType> values = <CallSignalType> [
    CallSignalOffer,
    CallSignalAnswer,
  ];

  static final $core.Map<$core.int, CallSignalType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CallSignalType valueOf($core.int value) => _byValue[value];

  const CallSignalType._($core.int v, $core.String n) : super(v, n);
}

class GetRoomType extends $pb.ProtobufEnum {
  static const GetRoomType GetRoomTypeFromUserIdPrivate = GetRoomType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetRoomTypeFromUserIdPrivate');
  static const GetRoomType GetRoomTypeFromRoomId = GetRoomType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetRoomTypeFromRoomId');

  static const $core.List<GetRoomType> values = <GetRoomType> [
    GetRoomTypeFromUserIdPrivate,
    GetRoomTypeFromRoomId,
  ];

  static final $core.Map<$core.int, GetRoomType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetRoomType valueOf($core.int value) => _byValue[value];

  const GetRoomType._($core.int v, $core.String n) : super(v, n);
}

class RoomStatus extends $pb.ProtobufEnum {
  static const RoomStatus RoomNotExisting = RoomStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RoomNotExisting');
  static const RoomStatus RoomInvitePending = RoomStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RoomInvitePending');
  static const RoomStatus RoomAcceptPending = RoomStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RoomAcceptPending');
  static const RoomStatus RoomAccepted = RoomStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RoomAccepted');

  static const $core.List<RoomStatus> values = <RoomStatus> [
    RoomNotExisting,
    RoomInvitePending,
    RoomAcceptPending,
    RoomAccepted,
  ];

  static final $core.Map<$core.int, RoomStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RoomStatus valueOf($core.int value) => _byValue[value];

  const RoomStatus._($core.int v, $core.String n) : super(v, n);
}

class RoomType extends $pb.ProtobufEnum {
  static const RoomType RoomTypeUnknown = RoomType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RoomTypeUnknown');
  static const RoomType RoomTypePrivate = RoomType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RoomTypePrivate');
  static const RoomType RoomTypeGroup = RoomType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RoomTypeGroup');

  static const $core.List<RoomType> values = <RoomType> [
    RoomTypeUnknown,
    RoomTypePrivate,
    RoomTypeGroup,
  ];

  static final $core.Map<$core.int, RoomType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RoomType valueOf($core.int value) => _byValue[value];

  const RoomType._($core.int v, $core.String n) : super(v, n);
}

