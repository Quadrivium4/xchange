import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xchange/controllers/auth.dart';
import 'package:xchange/providers/auth.dart';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  AuthProvider authProvider;
  bool isSubmitting = false;
  String? error;
  RegisterViewModel({required this.authProvider}) {
    init();
  }
  init() {
    email.addListener(notifyListeners);
  }

  handleRegister(BuildContext context) async {
    TRegisterCredentials credentials = TRegisterCredentials(
      name: name.text.trim(),
      email: email.text.trim(),
      password: password.text.trim(),
    );
    try {
      final result = await authProvider.registerEmailPassword(credentials);
      context.go("/onboarding");
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text(e.toString())),
            backgroundColor: Colors.redAccent,
          ),
        );
        print("handle register error " + e.toString());
      } else {
        print("Context not mounteddddddd!!!!!");
      }
    }

    //context.go("/");
  }

  cli() {
    print("hello cli");
    error = "idiot";
    notifyListeners();
  }

  handleGoogleLogin(BuildContext context) async {

    try {
      //await authProvider.googleLogin();
    } catch (e) {
      //context.go("/");
      print(e);
    }
  }
}
