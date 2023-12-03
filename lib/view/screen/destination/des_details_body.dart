import 'package:firebase_auth/firebase_auth.dart';
import 'package:ye_airways/model/des_argument.dart';
import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/destination/choose_seat_page.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:ye_airways/view/widgets/interest_item.dart';
import 'package:ye_airways/view/widgets/photo_item.dart';
import 'package:flutter/material.dart';

class Destination_Details_Body extends StatefulWidget {
  const Destination_Details_Body(
      {super.key, required this.image, required this.destination});
  final HN_DestinatioModel destination;
  final String image;

  @override
  State<Destination_Details_Body> createState() =>
      _Destination_Details_BodyState();
}

class _Destination_Details_BodyState extends State<Destination_Details_Body> {
  User? user = FirebaseAuth.instance.currentUser;

  bool isOrder = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DestinationArgument desArgument =
        ModalRoute.of(context)!.settings.arguments as DestinationArgument;

    return SingleChildScrollView(
      child: Stack(
        children: [
          //=========================== backgroundImage ===========================
          Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.destination.desImage!))),
          ),
          //=========================== customShadow ===========================
          Container(
            width: double.infinity,
            height: 214,
            margin: const EdgeInsets.only(top: 236),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kWhiteColor.withOpacity(0),
                    Colors.black.withOpacity(0.95)
                  ]),
            ),
          ),
          //=========================== content ===========================
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30, left: 24, right: 24),
            child: Column(children: [
              Container(
                width: 108,
                height: 24,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/icon_emblem.png',
                  ),
                )),
              ),

              // NOTE: title
              Container(
                margin: const EdgeInsets.only(top: 256),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.destination.placename!,
                          style: whiteTextStyle.copyWith(
                              fontSize: 24, fontWeight: semiBold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.destination.to!,
                          style: whiteTextStyle.copyWith(
                              fontSize: 16, fontWeight: light),
                        )
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
                        '${widget.destination.rating}',
                        style: whiteTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      )
                    ],
                  ),
                ]),
              ),

              //NOTE: Descripstion
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Text(
                        //   '${widget.destination.from}',
                        //   style: blackTextStyle.copyWith(
                        //       fontSize: 25, fontWeight: semiBold),
                        // ),
                        // SizedBox(
                        //   width: 50,
                        // ),
                        // Icon(
                        //   Icons.flight_takeoff_sharp,
                        //   size: 40,
                        // ),
                        // Text(
                        //   '${widget.destination.to}',
                        //   style: blackTextStyle.copyWith(
                        //       fontSize: 25, fontWeight: semiBold),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      'About',
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.destination.description!,
                      style: blackTextStyle.copyWith(height: 2),
                    ),
                    //NOTE: Photos
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Photos',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (final image in widget.destination.desOtherImages!)
                          PhotoItem(
                            imageUrl: image,
                          ),
                      ],
                    ),
                    //Note: Interest
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Interests',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        InterestItem(
                          text: 'Kids Park',
                        ),
                        InterestItem(
                          text: 'Honor Bridge',
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        InterestItem(
                          text: 'City Museum',
                        ),
                        InterestItem(
                          text: 'Central Mall',
                        )
                      ],
                    ),
                  ],
                ),
              ),

              //NOTE: PRICE & BOOK BUTTON
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  children: [
                    //NOTE: PRICE
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$ ${widget.destination.ticketPrice} ',
                            style: blackTextStyle.copyWith(
                                fontSize: 20, fontWeight: medium),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'per orang',
                            style: greyTextStyle.copyWith(
                                fontWeight: light, fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    //NOTE: BOOK BUTTON
                    CustomButton(
                      title: 'Book Now',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseSeatPage(
                                destination: widget.destination,
                              ),
                            ));

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => MyFlights_YE(),
                        //     ));

                        // Navigator.push(context, HomePage_HN());
                      },
                      width: 200,
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
