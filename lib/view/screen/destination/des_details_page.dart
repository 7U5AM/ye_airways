import 'package:ye_airways/model/des_argument.dart';
import 'package:flutter/material.dart';
import 'package:ye_airways/view/screen/destination/des_details_body.dart';

class DesDetailPage extends StatefulWidget {
  static const String id = 'DesDetailPage';

  const DesDetailPage({super.key});

  @override
  State<DesDetailPage> createState() => _DesDetailPageState();
}

class _DesDetailPageState extends State<DesDetailPage> {
  @override
  Widget build(BuildContext context) {
    DestinationArgument desArgument =
        ModalRoute.of(context)!.settings.arguments as DestinationArgument;

    return Scaffold(
        body: SafeArea(
      child: Destination_Details_Body(
          image: desArgument.destinationArg.desImage,
          destination: desArgument.destinationArg),
    ));
  }
}
