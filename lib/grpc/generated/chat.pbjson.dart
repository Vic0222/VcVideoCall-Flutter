///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const RoomType$json = const {
  '1': 'RoomType',
  '2': const [
    const {'1': 'Unknown', '2': 0},
    const {'1': 'Private', '2': 1},
    const {'1': 'Group', '2': 2},
  ],
};

const JoinRequest$json = const {
  '1': 'JoinRequest',
};

const JoinResponse$json = const {
  '1': 'JoinResponse',
  '2': const [
    const {'1': 'confirmation', '3': 1, '4': 1, '5': 8, '10': 'confirmation'},
    const {'1': 'message_notification', '3': 2, '4': 1, '5': 11, '6': '.chat.MessageNotification', '10': 'messageNotification'},
  ],
};

const MessageNotification$json = const {
  '1': 'MessageNotification',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'sender', '3': 2, '4': 1, '5': 9, '10': 'sender'},
    const {'1': 'message_body', '3': 3, '4': 1, '5': 9, '10': 'messageBody'},
  ],
};

const MessageRequest$json = const {
  '1': 'MessageRequest',
  '2': const [
    const {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'message_body', '3': 4, '4': 1, '5': 9, '10': 'messageBody'},
  ],
};

const MessageResponse$json = const {
  '1': 'MessageResponse',
};

const GetRoomsRequest$json = const {
  '1': 'GetRoomsRequest',
};

const GetRoomsResponse$json = const {
  '1': 'GetRoomsResponse',
  '2': const [
    const {'1': 'rooms', '3': 1, '4': 3, '5': 11, '6': '.chat.Room', '10': 'rooms'},
  ],
};

const Room$json = const {
  '1': 'Room',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.chat.RoomType', '10': 'type'},
    const {'1': 'last_message', '3': 4, '4': 1, '5': 9, '10': 'lastMessage'},
    const {'1': 'last_message_datetime', '3': 5, '4': 1, '5': 3, '10': 'lastMessageDatetime'},
  ],
};

const GetMessagesRequest$json = const {
  '1': 'GetMessagesRequest',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const GetMessagesResponse$json = const {
  '1': 'GetMessagesResponse',
  '2': const [
    const {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.chat.Message', '10': 'messages'},
  ],
};

const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'message_body', '3': 2, '4': 1, '5': 9, '10': 'messageBody'},
    const {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
  ],
};

