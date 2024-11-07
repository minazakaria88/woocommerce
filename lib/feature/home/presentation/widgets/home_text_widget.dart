import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khoyout/feature/home/presentation/widgets/my_text_widget.dart';



class HomeTextWidget extends StatelessWidget {
  const HomeTextWidget({
    super.key, required this.text, required this.onTap, required this.textButton,
  });
  final String text;
  final Function onTap;
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style:  const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextButtonWidget(
                onTap: (){
                  onTap();
                },
                text: textButton
            ),
          ],
        ),
      ),
    );
  }
}