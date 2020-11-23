///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const RoomTypeReply$json = const {
  '1': 'RoomTypeReply',
  '2': const [
    const {'1': 'Unknown', '2': 0},
    const {'1': 'Private', '2': 1},
    const {'1': 'Group', '2': 2},
  ],
};

const Notification$json = const {
  '1': 'Notification',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'sender', '3': 2, '4': 1, '5': 9, '10': 'sender'},
    const {'1': 'message_body', '3': 3, '4': 1, '5': 9, '10': 'messageBody'},
  ],
};

const MessageRequest$json = const {
  '1': 'MessageRequest',
  '2': const [
    const {'1': 'target', '3': 1, '4': 1, '5': 9, '10': 'target'},
    const {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.chat.RoomTypeReply', '10': 'type'},
    const {'1': 'message_body', '3': 4, '4': 1, '5': 9, '10': 'messageBody'},
  ],
};

const RoomRequest$json = const {
  '1': 'RoomRequest',
};

const RoomListReply$json = const {
  '1': 'RoomListReply',
  '2': const [
    const {'1': 'rooms', '3': 1, '4': 3, '5': 11, '6': '.chat.RoomReply', '10': 'rooms'},
  ],
};

const RoomReply$json = const {
  '1': 'RoomReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.chat.RoomTypeReply', '10': 'type'},
    const {'1': 'last_message', '3': 4, '4': 1, '5': 9, '10': 'lastMessage'},
  ],
};

