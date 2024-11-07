import 'package:flutter/material.dart';
import 'package:khoyout/core/widgets/my_button.dart';

import '../../generated/l10n.dart';
import '../utils/app_colors.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    super.key,
    required this.onTap, this.color,
  });
  final Function onTap;
  final Color ?color;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(S.of(context).areyousure),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyButton(
            text: S.of(context).cancel,
            onTap: () {
              Navigator.pop(context);
            },
            color: Colors.red,
          ),
          const SizedBox(
            height: 15,
          ),
          MyButton(
            color: color??AppColors.primaryColor,
            text: S.of(context).confirm,
            onTap: ()async {
              await onTap();
            },
          ),
        ],
      ),
    );
  }
}