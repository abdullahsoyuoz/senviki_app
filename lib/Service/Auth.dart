import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senviki_app/Model/UserEntity.dart';
import 'package:senviki_app/Service/UserFirestore.dart';

class AppAuth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register(
      String emailController, String passwordController,
      {String nameController}) async {
    try {
      return await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController, password: passwordController)
          .then((value) {
        UserFirestoreService.createUser(UserEntity(
          uid: value.user.uid,
          email: value.user.email,
          name: nameController,
        )).whenComplete(() => print('----- KAYIT EDILDI'));
      }).whenComplete(() {
        _firebaseAuth.currentUser.updateProfile(
          displayName: nameController.isEmpty ? '' : nameController,
        );
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserCredential> login(
      String emailController, String passwordController) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserCredential> updateProfile(
    String name,
    String password,
    String passwordR,
  ) async {
    if (name != null && password != null && passwordR != null) {
      await _firebaseAuth.currentUser
          .updatePassword(password)
          .whenComplete(() async {
        await _firebaseAuth.currentUser
            .updateProfile(displayName: name)
            .whenComplete(() async {
          await UserFirestoreService.updateUser(UserEntity(
              uid: FirebaseAuth.instance.currentUser.uid,
              email: FirebaseAuth.instance.currentUser.email,
              name: name));
        });
      });
    }
  }

  Future<UserCredential> signInAnonym() async {
    try {
      return await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      if (await GoogleSignIn().isSignedIn()) {
        GoogleSignIn().disconnect();
      }
      await _firebaseAuth.signOut().whenComplete(() => true);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserCredential> signInGoogle() async {
    try {
      final GoogleSignInAccount user = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication auth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      return await _firebaseAuth
          .signInWithCredential(credential)
          .whenComplete(() {
        UserFirestoreService.createUser(UserEntity(
          uid: FirebaseAuth.instance.currentUser.uid,
          email: FirebaseAuth.instance.currentUser.email,
          name: FirebaseAuth.instance.currentUser.displayName,
        ));
      });
    } on FirebaseAuth catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
