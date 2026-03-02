import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xchange/controllers/auth.dart';
import 'package:xchange/providers/auth.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isSubmitting = false;
  final AuthProvider authProvider;

  LoginViewModel({required this.authProvider});
  //initState() {}
  handleLogin(BuildContext context) async {
    isSubmitting = true;

    print("login with email: ${email.text} and pasword: ${password.text}");
    try {
      TLoginCredentials credentials = TLoginCredentials(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      await authProvider.signInEmailPassword(credentials);
      // if (authProvider.error != null) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(authProvider.error!)));
      //   print("handle login error " + authProvider.error!);
      // }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(e.toString())),
          backgroundColor: Colors.redAccent,
        ),
      );
      print("handle login error " + e.toString());
    }
    isSubmitting = false;
    notifyListeners();
  }

  handleGoogleLogin(BuildContext context) async {

    try {
      print("google login");
      //await authProvider.googleLogin();
      print("____________ LOGGED_______________");
    } catch (e) {
      print("error in view model: $e");
    }
  }
}
