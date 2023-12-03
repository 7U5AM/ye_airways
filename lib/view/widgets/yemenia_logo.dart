import 'package:flutter/material.dart';

class YemeniaLogo extends StatelessWidget {
  const YemeniaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50.0,
      width: 50.0,
      child: Image(
        image: AssetImage('assets/logo-ye.png'),
      ),
    );
  }
}
