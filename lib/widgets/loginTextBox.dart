import 'package:flutter/material.dart';

const Color onColor = Colors.orange;
const double onWidth = 5;
const Color offColor = Colors.grey;
const double offWidth = 2;

class LoginTextBox extends StatefulWidget {
  final TextEditingController controller;
  final Icon icon;
  final String label;
  final bool? hideText;
  const LoginTextBox({super.key, required this.controller, required this.icon, required this.label, this.hideText});

  @override
  State<LoginTextBox> createState() => _LoginTextBoxState();
}

class _LoginTextBoxState extends State<LoginTextBox> {

  final FocusNode focusNode = FocusNode();
  bool toggled = false;

   @override
   void initState() {
    super.initState();
    focusNode.addListener(() {
      if(focusNode.hasFocus != toggled){
        setState(() {
          toggled = !toggled;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: toggled ? onColor : offColor,
          width: toggled ? onWidth : offWidth,
      )
      ),

      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: TextField(

          focusNode: focusNode,
          controller: widget.controller,
          obscureText: widget.hideText ?? false,

          decoration: InputDecoration(
            icon: widget.icon,
            border: InputBorder.none,
            labelText: widget.label,
          ),
        ),
      ),
    );
  }
}