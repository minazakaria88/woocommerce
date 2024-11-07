
import 'package:flutter/material.dart';


import '../utils/app_colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    required this.valid,
    required this.textInputType, this.onTap, this.onChange,

  });
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final Function valid;
  final TextInputType textInputType;
  final Function ?onTap;
  final Function ? onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          return valid(value);
        },
        onTap: ()
        {
          if(onTap!=null) {
            onTap!();
          }
        },
        onChanged: (String value){
          if(onChange !=null)
            {
              onChange!(value);
            }
        },
        keyboardType: textInputType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: AppColors.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          label: Text(
            label,
          ),
          prefixIcon: Icon(
            prefixIcon,
          ),
        ),
      ),
    );
  }
}
