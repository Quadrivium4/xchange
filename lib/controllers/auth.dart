import "dart:convert";
import "dart:developer";
import "dart:math";

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";

import "package:google_sign_in/google_sign_in.dart";

_wait() async {
  await Future.delayed(Duration(milliseconds: 500));
}
class TLoginCredentials {
  final String email;
  final String password;
  TLoginCredentials({required this.email, required this.password});
}
class TRegisterCredentials extends TLoginCredentials {
  final String name;
  TRegisterCredentials({
    required this.name,
    required super.email,
    required super.password,
  });
}
class AuthController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  String? get uid => _auth.currentUser?.uid;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Future<void> signInEmailPassword(TLoginCredentials credentials) async {

    try {
      await _auth.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      print("successfully logged");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          {
            throw "Your email is invalid";
          }
        case "invalid-password":
          {
            throw "Your password is wrong";
          }
        default:
          {
            print("unkown error: ${e.code}");
            throw "Somthing went wrong";
          }
      }
      // if (e.code == "invalid-email") {

      // }else
      // print("hello firebase error");
      // inspect(e);
      // rethrow;
    }
  }

  Future<UserCredential> registerEmailPassword(
    TRegisterCredentials credentials,
  ) async {
    await _wait();
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: credentials.email,
            password: credentials.password,
          );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Firebase Error: ${e.message} ${credentials.email} ${credentials.password} ${credentials.password}");

      // print("exception ${e.message}\n code: ${e.code}");
      // return Result.error(e);
      switch (e.code) {
        case "invalid-email":
          {
            throw "Your email is invalid";
          }
        case "invalid-password":
          {
            throw "Your password is wrong";
          }
        default:
          {
            print("unkown error: ${e.code}");
            throw "Somthing went wrong";
          }
      }
    }
  }

  Future<void> signOut() async {
    await _wait();
    await _auth.signOut();
    GoogleSignIn().disconnect();
  }

  Future<void> resetPassword({required String email}) async {
    await _wait();
    try {
      await _auth.sendPasswordResetEmail(email: email);
     
    } on Exception catch (e) {
      return print("error $e");
    }

    GoogleSignIn().disconnect();
  }

  Future<UserCredential?> googleLogin() async {
    await _wait();

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      print("current user: ");
      return userCredential;
    } on Exception catch (e) {
      // TODO
      print("error in auth controller $e");
    
      //print('exception->$e');
    }
  }
}

rethrowFirebaseAuthError(e){
  switch (e.code) {
        case "invalid-email":
          {
            throw "Your email is invalid";
          }
        case "invalid-password":
          {
            throw "Your password is wrong";
          }
        default:
          {
            print("unkown error: ${e.code}");
            throw "Somthing went wrong";
          }
      }
    
}
