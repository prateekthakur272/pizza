import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements BaseUserRepository {
  final FirebaseAuth _firebaseAuth;
  final _userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await _userCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<MyUser> signUp(MyUser user, String password) async {
    try {
      UserCredential creds = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      user.id = creds.user!.uid;
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((user) async* {
      if (user == null) {
        yield null;
      } else {
        yield await _userCollection
            .doc(user.uid)
            .get()
            .then((data) => MyUser.fromMap(data.data()!));
      }
    });
  }
}