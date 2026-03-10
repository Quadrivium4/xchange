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
    authController.authStateChanges.listen((authUser) async {
      print("auth state changed: ${authUser}");
      if(authUser == null){
        logged = false;
        loading = false;
        notifyListeners();
        return;
      }else{
        print("logging in user with uid: ${authUser.uid}");
        try {
          user = await userController.getUser(authUser.uid);
          logged = true;
          loading = false;
          notifyListeners();
        } catch (e) {
           print("error getting user data: $e");
          logged = false;
          loading = false;
          notifyListeners();
        }
      }

      
      // print("auth state changed: ${user}");
      // if (user != null) {

      //   logged = true;
      //   loading = false;
      //   print("logged: $logged");
      //   notifyListeners();
      // }
      // if (user != null && uid == null) {
      //   uid = user.uid;
      //   loading = false;
      //   notifyListeners();
      // } else if (user == null && uid != null) {
      //   uid = null;
      //   loading = false;
      //   notifyListeners();
      // }
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
  signOut() async {
    await authController.signOut();
    logged = false;
    notifyListeners();
  }
  setOnboarded(bool onboarded) async {
    if(user == null) return;
    final updatedUser = user!.copyWith(onboarded: onboarded);
    await userController.updateUser(updatedUser);
    user = updatedUser;
    notifyListeners();
  }
  AuthProvider(){
    initState();
  }
}