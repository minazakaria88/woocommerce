import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onTap,this.color});
  final String text;
  final Function onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: color??AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8)
      ),
      child: MaterialButton(
        onPressed: (){
          onTap();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

      ),
    );
  }
}
