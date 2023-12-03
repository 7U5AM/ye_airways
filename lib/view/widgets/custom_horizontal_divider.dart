import 'package:flutter/material.dart';
import 'package:ye_airways/shared/styles/colors.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.0,
      thickness: 1.5,
      color: kLinesColor,
    );
  }
}
