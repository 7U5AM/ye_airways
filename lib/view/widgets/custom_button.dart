import 'package:ye_airways/view/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:ye_airways/shared/styles/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final EdgeInsets margin;
  final Function() onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: 50,
      child: TapEffect(
        onClick: onPressed,
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17))),
            onPressed: onPressed,
            child: Text(
              title,
              style:
                  whiteTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
            )),
      ),
    );
  }
}
