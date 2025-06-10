import 'package:blog/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  Future<UserModel> createUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        id: userCred.user!.uid,
        username: username,
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
      debugPrint('User created successfully');
      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error creating user');
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );
      UserModel user = UserModel(
        id: userCred.user!.uid,
        username: googleUser.displayName ?? '',
        email: googleUser.email ?? '',
        password: '',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
      debugPrint('User created successfully');
    } catch (e) {
      debugPrint("Error signing up with Google: ${e.toString()}");
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCred.user!.uid)
              .get();
      if (user.exists) {
        debugPrint('User signed in successfully');
        return UserModel.fromJson(user.data()!);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      debugPrint("Error signing in: ${e.toString()}");
      throw Exception('Error signing in repository');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );
      debugPrint('User signed in successfully');
    } catch (e) {
      debugPrint("Error signing in with Google: ${e.toString()}");
    }
  }

  Future<List<UserModel>> getUsers() async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    return users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    debugPrint('User signed out successfully');
  }

  Stream<List<UserModel>> streamUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => UserModel.fromJson(doc.data()))
                  .toList(),
        );
  }
}
