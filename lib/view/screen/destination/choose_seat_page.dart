import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/model/ticket_ye_model.dart';
import 'package:ye_airways/provider/destination_provider.dart';
import 'package:ye_airways/provider/flight_provider.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/checkout/checkout_page.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:ye_airways/view/widgets/myalert.dart';
import 'package:ye_airways/view/widgets/seat_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseSeatPage extends StatefulWidget {
  const ChooseSeatPage({super.key, required this.destination});
  final HN_DestinatioModel destination;

  @override
  State<ChooseSeatPage> createState() => _ChooseSeatPageState();
}

class _ChooseSeatPageState extends State<ChooseSeatPage> {
  List<String>? getTotalSeats;
  double? getTotalPrice;
  // User? user;
  @override
  void initState() {
    getTotalSeats = [];
    print("User = ${uid != "" ? uid : Null} =-=-=-=-=-=-=-=-=-=-");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int statusSeat = 0;
    DestinationProvider destinationProvider =
        Provider.of<DestinationProvider>(context);
    FlightProvider flightProvider = Provider.of<FlightProvider>(context);
    HN_DestinatioModel? objDestinatiomModel;
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          'Select Your\nFavorite Seat',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
        ),
      );
    }

    Widget seatStatus() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(children: [
          //AVAILABLE
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icon_available.png'))),
          ),
          Text(
            'Available',
            style: blackTextStyle,
          ),

          //SELECTED
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(left: 10, right: 6),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icon_selected.png'))),
          ),
          Text(
            'Selected',
            style: blackTextStyle,
          ),

          //UNAVAILABLE
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(left: 10, right: 6),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icon_unavailable.png'))),
          ),
          Text(
            'Unavailable',
            style: blackTextStyle,
          )
        ]),
      );
    }

    void changestatus(
        HN_DestinatioModel seatsDestination, int status, int index) {
      if (status == 0) {
        seatsDestination.seats![index].state = "1";
        seatsDestination.seats![index].userId = uid;
        destinationProvider.updateDestination(seatsDestination);
      } else if (status == 1 && seatsDestination.seats![index].userId == uid) {
        seatsDestination.seats![index].state = "0";
        seatsDestination.seats![index].userId = "";
        destinationProvider.updateDestination(seatsDestination);
      } else {
        MyAlert.errorAlert(context, desc: "This seat is not available!");
      }
    }

    Widget selectSeat() {
      return StreamBuilder<QuerySnapshot>(
        stream: destinationProvider.getDestinaion(widget.destination.desId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            HN_DestinatioModel destination = HN_DestinatioModel();

            for (final doc in snapshot.data!.docs) {
              HN_DestinatioModel dest = HN_DestinatioModel.fromDocument(doc);
              if (widget.destination.desId == dest.desId) {
                destination = dest;
                objDestinatiomModel = dest;
              }
            }

            getTotalSeats = destinationProvider.getUserSeats(destination, uid);
            getTotalSeats!.sort((a, b) => a.length.compareTo(b.length));
            widget.destination.userSeats = getTotalSeats;
            getTotalPrice = destination.ticketPrice! * getTotalSeats!.length;
            destinationProvider.updateDestination(destination);

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: kWhiteColor),
                  child: Column(
                    children: [
                      //SEAT INDICATORS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Text(
                                  'A',
                                  style: greyTextStyle.copyWith(fontSize: 25),
                                ),
                              )),
                          SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Text(
                                  'B',
                                  style: greyTextStyle.copyWith(fontSize: 25),
                                ),
                              )),
                          SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Text(
                                  '',
                                  style: greyTextStyle.copyWith(fontSize: 16),
                                ),
                              )),
                          SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Text(
                                  'C',
                                  style: greyTextStyle.copyWith(fontSize: 25),
                                ),
                              )),
                          SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: Text(
                                  'D',
                                  style: greyTextStyle.copyWith(fontSize: 25),
                                ),
                              )),
                        ],
                      ),
                      //NOTE SEAT 1
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A1"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B1"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C1"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D1"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE SEAT 2
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A2"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B2"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C2"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D2"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE SEAT 3
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A3"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B3"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '3',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C3"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D3"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE SEAT 4
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A4"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B4"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '4',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C4"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D4"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE SEAT 5
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A5"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B5"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '5',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C5"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D5"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE SEAT 6
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A6"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B6"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '6',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C6"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D6"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE SEAT 7
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A7"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B7"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '7',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C7"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D7"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE SEAT 8
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (index) {
                              if (index == 0) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("A8"));
                                // print("indexseat $indexseat ===================");
                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 1) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("B8"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else if (index == 2) {
                                return SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      '8',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              } else if (index == 3) {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("C8"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              } else {
                                int indexseat = destination.seats!.indexWhere(
                                    (element) =>
                                        element.column!.startsWith("D8"));

                                return SeatItem(
                                  onTap: () {
                                    changestatus(
                                        destination,
                                        int.parse(destination
                                            .seats![indexseat].state!),
                                        indexseat);
                                  },
                                  status: (destination
                                                  .seats![indexseat].state! ==
                                              "1" &&
                                          destination
                                                  .seats![indexseat].userId! ==
                                              uid)
                                      ? 1
                                      : (destination.seats![indexseat].state! ==
                                                  "1" &&
                                              destination.seats![indexseat]
                                                      .userId! !=
                                                  uid)
                                          ? 2
                                          : 0,
                                );
                              }
                            })),
                      ),

                      //NOTE : YOUR SEAT

                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Your seat:',
                            //   style: greyTextStyle.copyWith(
                            //     fontWeight: light,
                            //   ),
                            // ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  )),
                              child: DropdownButton<String>(
                                icon: const Icon(
                                    Icons.arrow_drop_down_circle_outlined),
                                underline: const SizedBox(),
                                dropdownColor: kWhiteColor,
                                hint: SizedBox(
                                  width: 300,
                                  child: Text('Yor Seats',
                                      style: greyTextStyle.copyWith(
                                          fontWeight: light)),
                                ),
                                items:
                                    getTotalSeats!.map((String dropDownItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownItem,
                                    child: Text(
                                      dropDownItem,
                                      style: blackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: medium,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  // setState(() {
                                  //   this.destTypeSelected = newValue;
                                  // });
                                },
                                // value: destTypeSelected,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //NOTE : TOTAL
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: greyTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                            Text(
                              '\$ $getTotalPrice',
                              style: purpleTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: kBackgroundColor,
                  child: CustomButton(
                    title: 'Continue to Checkout',
                    onPressed: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        User? user3 = FirebaseAuth.instance.currentUser;
                        return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("userTickets")
                                .doc(uid)
                                .collection(user3!.email!)
                                .doc(widget.destination.desId)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.exists) {
                                  Ticket_YE_Model ticketYeModel =
                                      Ticket_YE_Model.fromDocument(
                                          snapshot.data!);
                                  return CheckoutPage(
                                    ticketNumber: ticketYeModel.ticketNumber!,
                                    destination: destination,
                                    getTotalSeats: getTotalSeats,
                                  );
                                } else {
                                  int random = Random().nextInt(50) + 4;
                                  String userTicketNo = "YT6682$random";

                                  return CheckoutPage(
                                    ticketNumber: random.toString(),
                                    destination: destination,
                                    getTotalSeats: getTotalSeats,
                                  );
                                }
                              } else {
                                return Container(
                                  color: kWhiteColor,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        color: kPrimaryColor),
                                  ),
                                );
                              }
                            });
                      }));
                    },
                    margin: const EdgeInsets.only(top: 30, bottom: 46),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      );
    }

/*
    Widget checkoutButton() {
      return CustomButton(
        title: 'Continue to Checkout',
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                        destination: widget.destination,
                        getTotalSeats: getTotalSeats,
                      )));
        },
        margin: EdgeInsets.only(top: 30, bottom: 46),
      );
    }
*/
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            title(), seatStatus(), selectSeat()
            // , checkoutButton()
          ],
        ),
      ),
    );
  }
}
