import 'package:flutter/material.dart';

const Color onColor = Colors.orange;
const double onWidth = 5;
const Color offColor = Colors.grey;
const double offWidth = 2;

class LoginTextBox extends StatefulWidget {
  final TextEditingController controller;
  final Icon? icon;
  final String? label;
  final String? hint;
  final bool? hideText;
  final String? title; //Text widget before the TextField
  const LoginTextBox({super.key, required this.controller, this.icon, this.label, this.hint ,this.hideText, this.title});

  @override
  State<LoginTextBox> createState() => _LoginTextBoxState();
}

class _LoginTextBoxState extends State<LoginTextBox> {

  final FocusNode focusNode = FocusNode();

   @override
   void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        widget.title != null ? Text(widget.title!) : SizedBox.shrink(),

        Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: focusNode.hasFocus ? onColor : offColor,
              width: focusNode.hasFocus ? onWidth : offWidth,
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
                hint: widget.hint == null ? null : Text(widget.hint!),
              ),
            ),
          ),
        ),
      ],
    );
  }
}