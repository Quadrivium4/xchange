import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xchange/pages/auth/login/login_view_model.dart';
import 'package:xchange/pages/auth/register/register_view_model.dart';
import 'package:xchange/widgets/Buttons/confirmationButton.dart';
import 'package:xchange/widgets/loginTextBox.dart';
import 'package:xchange/widgets/Structure/spacedColumn.dart';


class RegisterView extends StatelessWidget{
  const RegisterView({super.key});


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: SpacedColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("XChange",),
            Text("Create account"),
            LoginTextBox(controller: viewModel.name, icon: Icon(Icons.account_box), label: "Name",),
            LoginTextBox(controller: viewModel.email, icon: Icon(Icons.email_outlined), label: "Email"),
            LoginTextBox(controller: viewModel.password, icon: Icon(Icons.lock_outlined), label: "password", hideText: true,),

            ConfirmationButton(
                onPressed: (){
                  viewModel.handleRegister(context);
                },
                text: "Register",
                icon: Icons.arrow_forward,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: (){
                    context.go("/login");
                  },
                  child: Text("Login", style: TextStyle(color: Colors.orange),),
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