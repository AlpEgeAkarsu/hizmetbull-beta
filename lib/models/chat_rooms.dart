class UserChatRooms {
  UserChatRooms({this.roomId, this.chatIds});
  String roomId;
  List<String> chatIds;

  factory UserChatRooms.fromJson(Map<String, dynamic> json) => UserChatRooms(
        roomId: json["roomId"] == null ? null : json["roomId"],
        chatIds: json["chatIds"] == null
            ? null
            : List<String>.from(json["chatIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId == null ? null : roomId,
        "chatIds":
            chatIds == null ? null : List<dynamic>.from(chatIds.map((x) => x)),
      };
}
