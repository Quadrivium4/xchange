
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xchange/pages/auth/login/login_view_model.dart';
import 'package:xchange/providers/auth.dart';
import 'package:xchange/widgets/Buttons/confirmationButton.dart';
import 'package:xchange/widgets/loginTextBox.dart';
import 'package:xchange/widgets/Structure/spacedColumn.dart';


class SettingsView extends StatelessWidget{
  const SettingsView({super.key});


  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return Center(
      child: TextButton(onPressed: (){
        authProvider.signOut();
      }, child: Text("logout"))
                 
      
    );
  }
}