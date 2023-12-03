import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/provider/destination_provider.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DestinationTile extends StatelessWidget {
  final int index;
  final HN_DestinatioModel destinatioModel;
  final Function()? press;

  const DestinationTile(
      {super.key,
      required this.index,
      required this.destinatioModel,
      required this.press});

  @override
  Widget build(BuildContext context) {
    DestinationProvider destinationProvider =
        Provider.of<DestinationProvider>(context);
    /*
    DestinationArgument desArgument =
        ModalRoute.of(context)!.settings.arguments as DestinationArgument;
        */
    // Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
          // width: 72,
          height: 72,
          margin: const EdgeInsets.only(top: 16),
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(destinatioModel.desImage!),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinatioModel.placename!,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(destinatioModel.to!,
                        style: greyTextStyle.copyWith(fontWeight: light))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 2),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icon_star.png'),
                      ),
                    ),
                  ),
                  Text(
                    destinatioModel.rating.toString(),
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
