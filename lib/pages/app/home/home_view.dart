import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xchange/controllers/user.dart';
import 'package:xchange/pages/auth/login/login_view_model.dart';
import 'package:xchange/providers/auth.dart';
import 'package:xchange/providers/user.dart';
import 'package:xchange/widgets/Buttons/confirmationButton.dart';
import 'package:xchange/widgets/loginTextBox.dart';
import 'package:xchange/widgets/Structure/spacedColumn.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final authProvider = context.watch<AuthProvider>();
    return Center(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Text("Welcome, ${userProvider.user.name}"),
             TextButton(
              onPressed: ()async {
                authProvider.setOnboarded(false);
              },
              child: Text("set onboarded to false"),
            ),
          ],
        ),
      ),
    );
  }
}
