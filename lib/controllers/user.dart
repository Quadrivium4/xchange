import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  bool onboarded;
  String uid;


  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.onboarded,

  }) ;

  factory UserModel.fromDocument(TFirestoreResonse snap) {
    final data = snap.data();
    //print("streak ${data?["streak"]}");
    return UserModel(
      name: data?['name'] ?? "",
      email: data?['email'] ?? "",
      onboarded: data?['onboarded'] ?? false,
      uid: snap.id,
    );
  }
  copyWith({
    String? name,
    String? email,
    bool? onboarded,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      onboarded: onboarded ?? this.onboarded,
      uid: uid,
    );
  }
  toJson(){
    return {
      'name': name,
      'email': email,
      'onboarded': onboarded,
    };
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
        'onboarded': false,
      });
      
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      //print("getting user: $uid");
      //await _wait();
      final data = await _db.collection("users").doc(uid).get();
      //print("getted user snapshot: ${data.data()}");
      return UserModel.fromDocument(data);
    } catch (err) {
      print("ERROR found");
      rethrow;
    }
  }

  Future<dynamic> updateUser(UserModel newUser) async {
    await _db.collection("users").doc(newUser.uid).update(newUser.toJson());
  }



  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> onChange(
    Function(UserModel) callback,
    String uid,
  ) {
    //print("auth uid: $uid");
    return _db.collection("users").doc(uid).snapshots().listen((snap) {
      final user = UserModel.fromDocument(snap);
      callback(user);
    });
  }

}
