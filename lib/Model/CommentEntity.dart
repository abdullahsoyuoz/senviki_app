import 'dart:convert';

class CommentEntity {
  String documentId;
  String newsId;
  String message;
  DateTime messageDate;
  String messageImageUrl;
  String userUid;
  CommentEntity parentComment;
  int key;

  CommentEntity({
    this.documentId,
    this.newsId,
    this.message,
    this.messageDate,
    this.messageImageUrl,
    this.userUid,
    this.parentComment,
    this.key,
  });

  factory CommentEntity.fromMap(Map<String, dynamic> json) {
    return CommentEntity(
      documentId:           json["documentId"] == null ? null : json["documentId"],
      newsId:               json["newsId"] == null ? null : json["newsId"],
      message:              json["message"] == null ? null : json["message"],
      messageDate:          json["messageDate"] == null ? null : json["messageDate"].toDate(),
      messageImageUrl:      json["messageImageUrl"] == null ? null : json["messageImageUrl"],
      userUid:              json["userUID"] == null ? null : json["userUID"],
      parentComment:        json["parentComment"] == null ? null : CommentEntity.fromMap(json["parentComment"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "documentId":       documentId == null ? null : documentId,
        "newsId":           newsId == null ? null : newsId,
        "message":          message == null ? null : message,
        "messageDate":      messageDate == null ? null : messageDate,
        "messageImageUrl":  messageImageUrl == null ? null : messageImageUrl,
        "userUID":          userUid == null ? null : userUid,
        "parentComment":    parentComment == null ? null : parentComment.toMap(),
      };
}
