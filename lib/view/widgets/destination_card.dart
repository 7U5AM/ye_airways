import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/provider/destination_provider.dart';
import 'package:flutter/material.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:provider/provider.dart';

class DestinationCard extends StatelessWidget {
  final int index;
  final HN_DestinatioModel destinatioModel;
  final Function()? press;

  const DestinationCard(
      {super.key,
      required this.index,
      required this.destinatioModel,
      required this.press});

  @override
  Widget build(BuildContext context) {
    DestinationProvider destinationProvider =
        Provider.of<DestinationProvider>(context);

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        width: 200,
        height: 323,
        margin: const EdgeInsets.only(left: 24),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: kWhiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 180,
              height: 220,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      image: NetworkImage(destinatioModel.desImage!)
                      // Image.network(src),
                      //      Image(
                      //         image: Image.network(
                      //   destinatioModel.desImage!,
                      // ))
                      )),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 55,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                    ),
                  ),
                  child: Row(
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
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
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
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    destinatioModel.to!,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
