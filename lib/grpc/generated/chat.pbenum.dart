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
  static const CallOfferStatus Rejected = CallOfferStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Rejected');
  static const CallOfferStatus Accepted = CallOfferStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Accepted');

  static const $core.List<CallOfferStatus> values = <CallOfferStatus> [
    Rejected,
    Accepted,
  ];

  static final $core.Map<$core.int, CallOfferStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CallOfferStatus valueOf($core.int value) => _byValue[value];

  const CallOfferStatus._($core.int v, $core.String n) : super(v, n);
}

class CallSignalType extends $pb.ProtobufEnum {
  static const CallSignalType Offer = CallSignalType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Offer');
  static const CallSignalType Answer = CallSignalType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Answer');

  static const $core.List<CallSignalType> values = <CallSignalType> [
    Offer,
    Answer,
  ];

  static final $core.Map<$core.int, CallSignalType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CallSignalType valueOf($core.int value) => _byValue[value];

  const CallSignalType._($core.int v, $core.String n) : super(v, n);
}

class RoomType extends $pb.ProtobufEnum {
  static const RoomType Unknown = RoomType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Unknown');
  static const RoomType Private = RoomType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Private');
  static const RoomType Group = RoomType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Group');

  static const $core.List<RoomType> values = <RoomType> [
    Unknown,
    Private,
    Group,
  ];

  static final $core.Map<$core.int, RoomType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RoomType valueOf($core.int value) => _byValue[value];

  const RoomType._($core.int v, $core.String n) : super(v, n);
}

