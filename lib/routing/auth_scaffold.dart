

import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  Widget child;
  AuthScaffold({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
  
}