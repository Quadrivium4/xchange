import 'package:flutter/material.dart';

class ConfirmationButton extends StatelessWidget {
  final Function onPressed;
  final String? text;
  final IconData? icon;
  const ConfirmationButton({super.key, required this.onPressed, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){onPressed();},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text ?? "", style: TextStyle(color: Colors.white),),
          Icon(icon, color: Colors.white,),
        ],
      ),
    );
  }
}
