import 'package:flutter/material.dart';
import 'package:khoyout/core/utils/app_colors.dart';

void showSnackBarF({required BuildContext context, required String text,Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
    ),
    backgroundColor: color??AppColors.orange,
    duration: const Duration(milliseconds: 300),
  ));
}
