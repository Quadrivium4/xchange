import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xchange/controllers/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel user;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;
  UserController userController = UserController();

  //UserProvider({required this.user});
  initState(){
   _subscription =  userController.onChange((newUser){
    user = newUser;
    notifyListeners();
   }, user.uid);
  }
  editUser(UserModel newUser) {
    userController.updateUser(newUser);
  }
  @override
  void dispose() {
    print("disposing user provider...");
    if(_subscription != null ) _subscription?.cancel();
    super.dispose();
  }

  UserProvider({required this.user}) {
    initState();
  }
}