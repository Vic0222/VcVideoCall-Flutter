///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const JoinResponseType$json = const {
  '1': 'JoinResponseType',
  '2': const [
    const {'1': 'Confirmation', '2': 0},
    const {'1': 'Notification', '2': 1},
    const {'1': 'CallSignaling', '2': 2},
    const {'1': 'IceCandidate', '2': 3},
  ],
};

const CallOfferStatus$json = const {
  '1': 'CallOfferStatus',
  '2': const [
    const {'1': 'Rejected', '2': 0},
    const {'1': 'Accepted', '2': 1},
  ],
};

const CallSignalType$json = const {
  '1': 'CallSignalType',
  '2': const [
    const {'1': 'Offer', '2': 0},
    const {'1': 'Answer', '2': 1},
  ],
};

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
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.chat.JoinResponseType', '10': 'type'},
    const {'1': 'message_notification', '3': 2, '4': 1, '5': 11, '6': '.chat.MessageNotification', '10': 'messageNotification'},
    const {'1': 'call_offer_notification', '3': 3, '4': 1, '5': 11, '6': '.chat.CallOfferNotification', '10': 'callOfferNotification'},
    const {'1': 'ice_candidate_notification', '3': 4, '4': 1, '5': 11, '6': '.chat.IceCandidateNotification', '10': 'iceCandidateNotification'},
  ],
};

const IceCandidateRequest$json = const {
  '1': 'IceCandidateRequest',
  '2': const [
    const {'1': 'send_to_user_id', '3': 1, '4': 1, '5': 9, '10': 'sendToUserId'},
    const {'1': 'rtc_ice_candidate', '3': 2, '4': 1, '5': 11, '6': '.chat.RtcIceCandidate', '10': 'rtcIceCandidate'},
  ],
};

const IceCandidateResponse$json = const {
  '1': 'IceCandidateResponse',
};

const RtcSessionDescription$json = const {
  '1': 'RtcSessionDescription',
  '2': const [
    const {'1': 'sdp', '3': 1, '4': 1, '5': 9, '10': 'sdp'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
  ],
};

const IceCandidateNotification$json = const {
  '1': 'IceCandidateNotification',
  '2': const [
    const {'1': 'rtc_ice_candidate', '3': 1, '4': 1, '5': 11, '6': '.chat.RtcIceCandidate', '10': 'rtcIceCandidate'},
  ],
};

const RtcIceCandidate$json = const {
  '1': 'RtcIceCandidate',
  '2': const [
    const {'1': 'candidate', '3': 1, '4': 1, '5': 9, '10': 'candidate'},
    const {'1': 'sdpMid', '3': 2, '4': 1, '5': 9, '10': 'sdpMid'},
    const {'1': 'sdpMlineIndex', '3': 3, '4': 1, '5': 5, '10': 'sdpMlineIndex'},
  ],
};

const CallOfferRequest$json = const {
  '1': 'CallOfferRequest',
  '2': const [
    const {'1': 'rtc_session_description', '3': 1, '4': 1, '5': 11, '6': '.chat.RtcSessionDescription', '10': 'rtcSessionDescription'},
    const {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const CallOfferResponse$json = const {
  '1': 'CallOfferResponse',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.chat.CallOfferStatus', '10': 'status'},
    const {'1': 'rtc_session_description', '3': 2, '4': 1, '5': 11, '6': '.chat.RtcSessionDescription', '10': 'rtcSessionDescription'},
    const {'1': 'receiver_id', '3': 3, '4': 1, '5': 9, '10': 'receiverId'},
  ],
};

const CallAnswerRequest$json = const {
  '1': 'CallAnswerRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.chat.CallOfferStatus', '10': 'status'},
    const {'1': 'rtc_session_description', '3': 2, '4': 1, '5': 11, '6': '.chat.RtcSessionDescription', '10': 'rtcSessionDescription'},
    const {'1': 'room_id', '3': 3, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const CallAnswerResponse$json = const {
  '1': 'CallAnswerResponse',
};

const CallOfferNotification$json = const {
  '1': 'CallOfferNotification',
  '2': const [
    const {'1': 'sender_id', '3': 1, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'rtc_session_description', '3': 3, '4': 1, '5': 11, '6': '.chat.RtcSessionDescription', '10': 'rtcSessionDescription'},
  ],
};

const CallSignal$json = const {
  '1': 'CallSignal',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.chat.CallSignalType', '10': 'type'},
    const {'1': 'rtc_session_description', '3': 2, '4': 1, '5': 11, '6': '.chat.RtcSessionDescription', '10': 'rtcSessionDescription'},
  ],
};

const MessageNotification$json = const {
  '1': 'MessageNotification',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
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
    const {'1': 'last_message_datetime', '3': 2, '4': 1, '5': 3, '10': 'lastMessageDatetime'},
  ],
};

const GetMessagesResponse$json = const {
  '1': 'GetMessagesResponse',
  '2': const [
    const {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.chat.Message', '10': 'messages'},
    const {'1': 'last_message_datetime', '3': 2, '4': 1, '5': 3, '10': 'lastMessageDatetime'},
  ],
};

const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'message_body', '3': 3, '4': 1, '5': 9, '10': 'messageBody'},
    const {'1': 'sender_id', '3': 4, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'date_sent', '3': 5, '4': 1, '5': 3, '10': 'dateSent'},
  ],
};

