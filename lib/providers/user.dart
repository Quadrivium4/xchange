import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xchange/controllers/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel user;
  String uid;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;
  UserController userController = UserController();

  //UserProvider({required this.user});

  initState() async {
    user = await userController.getUser(uid);
  }


  @override
  void dispose() {
    print("disposing user provider...");
    if(_subscription != null ) _subscription?.cancel();
    super.dispose();
  }

  UserProvider({required this.uid, required this.user}) {
    initState();
  }
}