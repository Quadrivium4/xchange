import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xchange/controllers/auth.dart';
import 'package:xchange/controllers/user.dart';

class AuthProvider extends ChangeNotifier {
   String? uid;
  UserModel? user;
  bool loading = true;
  bool logged = false;
  String? error;
  AuthController authController = AuthController();
  UserController userController = UserController();
  initState() async {
    uid = authController.uid;
    print("auth provider init state: $uid");
    if (uid == null) {
      loading = false;
      notifyListeners();
    }
    // if (uid == null) {
    //   loading = false;
    // } else {
    //   loading = false;
    //   //login();
    // }
    authController.authStateChanges.listen((user) {
      //print("auth state changed: ${user}");
      if (user != null) {
        logged = true;
        loading = false;
        notifyListeners();
      }
      if (user != null && uid == null) {
        uid = user.uid;
        loading = false;
        notifyListeners();
      } else if (user == null && uid != null) {
        uid = null;
        loading = false;
        notifyListeners();
      }
    });
  }

  signInEmailPassword(TLoginCredentials credentials) async {
    return await authController.signInEmailPassword(credentials);
    //await authController.signInEmailPassword(credentials);
  }

  Future<void> registerEmailPassword(
    TRegisterCredentials credentials,
  ) async {
    print("register email and password");
    final UserCredential result = await authController
        .registerEmailPassword(credentials);

        await userController.createUser(
          name: credentials.name,
          email: credentials.email,
          uid: result.user!.uid,
        );
       
    
  }
}