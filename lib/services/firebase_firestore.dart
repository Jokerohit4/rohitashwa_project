
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rohitashwa_project/models/user_model.dart';


class FireStore {
  var db = FirebaseFirestore.instance;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) async {
    return usersCollection.doc(user.id).update(user.toMap());
  }

  Future<void> addUserPhoneNumber(String phone) async {
    return usersCollection.doc(FirebaseAuth.instance.currentUser?.uid).set({'ph':phone});
  }

  Future<Map<String, dynamic>?> fetchUser(user) async {
    // Get the document snapshot
    DocumentSnapshot docSnapshot = await usersCollection.doc(user).get();

    // Check if the document exists
    if (docSnapshot.exists) {
      // Get the data from the document
      Map<String, dynamic> userData = docSnapshot.data() as Map<String,
          dynamic>;
      // Return the user data
      return userData;
    } else {
      // Document doesn't exist
      return null;
    }
  }
}