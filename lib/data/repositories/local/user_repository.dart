import 'package:blog/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepository {
  Future<void> createUser(
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
