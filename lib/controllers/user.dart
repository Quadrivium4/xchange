import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;

  String uid;


  UserModel({
    required this.name,
    required this.email,
    required this.uid,

  }) ;

  factory UserModel.fromDocument(TFirestoreResonse snap) {
    final data = snap.data();
    //print("streak ${data?["streak"]}");
    return UserModel(
      name: data?['name'] ?? "",
      email: data?['email'] ?? "",
      uid: snap.id,
    );
  }
}

typedef TFirestoreResonse = DocumentSnapshot<Map<String, dynamic>>;

class UserController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> createUser({
    String? name,
    String? email,
    required String uid,
  }) async {
    print("creating user -------------- UID: $uid");
    //if (uid == null) throw "Invalid credentials";
    final userDoc = await _db.collection("users").doc(uid).get();
    if (!userDoc.exists) {
      
       await _db.collection("users").doc(uid).set({
        'name': name ?? "",
        'email': email ?? "",

      });
      
    }
  }

  Future<dynamic> getUser(String uid) async {
    try {
      //print("getting user: $uid");
      //await _wait();
      final data = await _db.collection("users").doc(uid).get();
      //print("getted user snapshot: ${data.data()}");
      return data;
    } catch (err) {
      print("ERROR found");
      rethrow;
    }
  }

  Future<dynamic> updateUser(UserModel newUser) async {

    _db.collection("users").doc(newUser.uid).update({
      "name": newUser.name,
    });
  }



  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> onChange(
    Function(TFirestoreResonse) callback,
    String uid,
  ) {
    //print("auth uid: $uid");
    return _db.collection("users").doc(uid).snapshots().listen((snap) {
      callback(snap);
    });
  }

}
