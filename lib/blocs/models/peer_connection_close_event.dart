class PeerConnectionCloseEvent {
  PeerConnectionCloseEvent(this.roomId, {this.fromServer});
  String roomId;
  bool fromServer;
}
