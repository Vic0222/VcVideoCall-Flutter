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
    const {'1': 'PeerConnectionClose', '2': 4},
  ],
};

const CallOfferStatus$json = const {
  '1': 'CallOfferStatus',
  '2': const [
    const {'1': 'CallOfferRejected', '2': 0},
    const {'1': 'CallOfferAccepted', '2': 1},
  ],
};

const CallSignalType$json = const {
  '1': 'CallSignalType',
  '2': const [
    const {'1': 'CallSignalOffer', '2': 0},
    const {'1': 'CallSignalAnswer', '2': 1},
  ],
};

const GetRoomType$json = const {
  '1': 'GetRoomType',
  '2': const [
    const {'1': 'GetRoomTypeFromUserIdPrivate', '2': 0},
    const {'1': 'GetRoomTypeFromRoomId', '2': 1},
  ],
};

const RoomStatus$json = const {
  '1': 'RoomStatus',
  '2': const [
    const {'1': 'RoomNotExisting', '2': 0},
    const {'1': 'RoomInvitePending', '2': 1},
    const {'1': 'RoomAcceptPending', '2': 2},
    const {'1': 'RoomAccepted', '2': 3},
  ],
};

const RoomType$json = const {
  '1': 'RoomType',
  '2': const [
    const {'1': 'RoomTypeUnknown', '2': 0},
    const {'1': 'RoomTypePrivate', '2': 1},
    const {'1': 'RoomTypeGroup', '2': 2},
  ],
};

const PeerConnectionCloseRequest$json = const {
  '1': 'PeerConnectionCloseRequest',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const PeerConnectionCloseResponse$json = const {
  '1': 'PeerConnectionCloseResponse',
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
    const {'1': 'peer_connection_close_notification', '3': 5, '4': 1, '5': 11, '6': '.chat.PeerConnectionCloseNotification', '10': 'peerConnectionCloseNotification'},
  ],
};

const IceCandidateRequest$json = const {
  '1': 'IceCandidateRequest',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
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
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'rtc_ice_candidate', '3': 2, '4': 1, '5': 11, '6': '.chat.RtcIceCandidate', '10': 'rtcIceCandidate'},
  ],
};

const PeerConnectionCloseNotification$json = const {
  '1': 'PeerConnectionCloseNotification',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
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

const GetRoomRequest$json = const {
  '1': 'GetRoomRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.chat.GetRoomType', '10': 'type'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'room_id', '3': 3, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const GetRoomResponse$json = const {
  '1': 'GetRoomResponse',
  '2': const [
    const {'1': 'room_status', '3': 1, '4': 1, '5': 14, '6': '.chat.RoomStatus', '10': 'roomStatus'},
    const {'1': 'room', '3': 2, '4': 1, '5': 11, '6': '.chat.Room', '10': 'room'},
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
    const {'1': 'is_online', '3': 6, '4': 1, '5': 8, '10': 'isOnline'},
    const {'1': 'photo_url', '3': 7, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.chat.RoomStatus', '10': 'status'},
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

const SearchUserRequest$json = const {
  '1': 'SearchUserRequest',
  '2': const [
    const {'1': 'keyword', '3': 1, '4': 1, '5': 9, '10': 'keyword'},
  ],
};

const SearchUserResponse$json = const {
  '1': 'SearchUserResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.chat.User', '10': 'users'},
  ],
};

const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'photo_url', '3': 4, '4': 1, '5': 9, '10': 'photoUrl'},
  ],
};

const UserInviteRequest$json = const {
  '1': 'UserInviteRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

const UserInviteResponse$json = const {
  '1': 'UserInviteResponse',
  '2': const [
    const {'1': 'room', '3': 1, '4': 1, '5': 11, '6': '.chat.Room', '10': 'room'},
  ],
};

const UserAcceptRequest$json = const {
  '1': 'UserAcceptRequest',
  '2': const [
    const {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

const UserAcceptResponse$json = const {
  '1': 'UserAcceptResponse',
  '2': const [
    const {'1': 'room', '3': 1, '4': 1, '5': 11, '6': '.chat.Room', '10': 'room'},
  ],
};

