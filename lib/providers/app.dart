

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xchange/providers/auth.dart';
import 'package:xchange/providers/user.dart';

class AppProviders extends StatelessWidget {
  Widget child;
  AppProviders({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider(user: authProvider.user!)),
    ], child: child);
  }
  
}