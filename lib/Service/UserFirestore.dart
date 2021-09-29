import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senviki_app/Model/UserEntity.dart';

class UserFirestoreService {
  static FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> getUserStream(String uid) {
    return firebaseInstance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  static Future<void> createUser(UserEntity user) async {
    await firebaseInstance.collection('users').doc(user.uid).set(user.toMap());
  }

  static Future<void> updateUser(UserEntity user) async {
    await firebaseInstance
        .collection('users')
        .doc(user.uid)
        .update(user.toMap())
        .then((value) => debugPrint(user.name + "Updated!"))
        .catchError((onError) => debugPrint(onError));
  }
}
