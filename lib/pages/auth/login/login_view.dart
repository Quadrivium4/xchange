import 'package:flutter/material.dart';
import 'package:xchange/widgets/loginTextBox.dart';
import 'package:xchange/widgets/spacedColumn.dart';


class LoginView extends StatefulWidget{
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController pswCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: SpacedColumn(
          spacing: 8,
          children: [

            Text("XChange",),
            Text("Access your account"),

            LoginTextBox(controller: emailCtrl, icon: Icon(Icons.email_outlined), label: "Email"),
            LoginTextBox(controller: pswCtrl, icon: Icon(Icons.lock_outlined), label: "password", hideText: true,),

            ElevatedButton(
                onPressed: (){/*To be filled with the login function*/},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: TextStyle(color: Colors.white,),),
                  Icon(Icons.arrow_forward, color: Colors.white,),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have an account?"),
                TextButton(
                  onPressed: (){/*To implement the function*/},
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