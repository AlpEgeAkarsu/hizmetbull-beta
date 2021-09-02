import 'package:cloud_firestore/cloud_firestore.dart';

class StoreMessage {
  String messageId;
  String content;
  Timestamp dateCreated;
  String sentBy;

  StoreMessage(this.content, this.messageId, this.dateCreated, this.sentBy);

  StoreMessage.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    messageId = documentSnapshot.id;
    content = documentSnapshot.data()["content"];
    dateCreated = documentSnapshot.data()["dateCreated"];
    sentBy = documentSnapshot.data()["sentBy"];
  }
}
