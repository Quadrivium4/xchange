import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xchange/pages/auth/login/login_view_model.dart';
import 'package:xchange/widgets/Buttons/confirmationButton.dart';
import 'package:xchange/widgets/loginTextBox.dart';
import 'package:xchange/widgets/Structure/spacedColumn.dart';


class LoginView extends StatelessWidget{
  const LoginView({super.key});


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: SpacedColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("XChange",),
            Text("Access your account"),

            LoginTextBox(controller: viewModel.email, icon: Icon(Icons.email_outlined), label: "Email"),
            LoginTextBox(controller: viewModel.password, icon: Icon(Icons.lock_outlined), label: "password", hideText: true,),

            ConfirmationButton(
                onPressed: (){
                  viewModel.handleLogin(context);
                },
                text: "Login",
                icon: Icons.arrow_forward,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have an account?"),
                TextButton(
                  onPressed: (){
                    context.go("/register");
                  },
                  child: Text("Register", style: TextStyle(color: Colors.orange),),
                ),
              ],
            ),

            TextButton(
                onPressed: (){/*To implement the function*/},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_red_eye_outlined, color: Colors.grey,),
                    SizedBox(width: 20,),
                    Text("Continue as a guest", style: TextStyle(color: Colors.grey),),
                  ],
                )
            ),

          ],
        ),
      )
    );
  }
}