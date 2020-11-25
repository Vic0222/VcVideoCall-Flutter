///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

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

