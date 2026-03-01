import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function onPressed;
  final String? text;
  final IconData? icon;
  const CustomBackButton({super.key, required this.onPressed, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){onPressed();},

      style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: Colors.orange,
            width: 2,
          )
      ),

      child: Row(
        children: [
          Icon(icon, color: Colors.orange,),
          Text(text ?? "", style: TextStyle(color: Colors.orange),)
        ],
      ),
    );
  }
}
