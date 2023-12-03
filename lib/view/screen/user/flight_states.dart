import 'package:ye_airways/shared/components/constantes.dart';
import 'package:flutter/material.dart';

class Flight_States extends StatelessWidget {
  const Flight_States({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kbackgroundColor,
      body: SafeArea(
        child: Center(
          child: Text('Flight States'),
        ),
      ),
    );
  }
}
