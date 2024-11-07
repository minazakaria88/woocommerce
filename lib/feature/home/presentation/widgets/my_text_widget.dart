import 'package:flutter/material.dart';


class MyTextButtonWidget extends StatelessWidget {
  const MyTextButtonWidget({super.key, required this.onTap, required this.text});
 final Function onTap;
 final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          onTap();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16
          ),
        ),
    );
  }
}
