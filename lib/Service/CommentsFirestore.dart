import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senviki_app/Model/CommentEntity.dart';

class CommentsFirestoreService {
  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> getStream(String newsId, bool isDesc) {
    return firestoreInstance
        .collection('comments') // CHANGE FROM COLLECTION NAME -> MESSAGES
        .where('newsId', isEqualTo: newsId)
        .orderBy('messageDate', descending: isDesc)
        .snapshots();
  }

  static Future<void> createMessage(CommentEntity message) async {
    final ref = firestoreInstance.collection('comments').doc(); // CHANGE FROM COLLECTION NAME -> MESSAGES
    message.documentId = ref.id;
    await ref.set(message.toMap());
  }

  static Future<void> updateMessage() {
    // todo:
  }

  static Future<void> deleteMessage(String documentId) async {}
}
