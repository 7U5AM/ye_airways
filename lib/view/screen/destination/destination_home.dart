import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ye_airways/model/des_argument.dart';
import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/provider/destination_provider.dart';
import 'package:ye_airways/view/screen/destination/des_details_page.dart';
import 'package:ye_airways/view/widgets/destination_card.dart';
import 'package:ye_airways/view/widgets/destination_tile.dart';
import 'package:flutter/material.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:provider/provider.dart';

class Destination_Home extends StatefulWidget {
  static const String id = 'Destination_Home';

  const Destination_Home({super.key});

  @override
  State<Destination_Home> createState() => _Destination_HomeState();
}

class _Destination_HomeState extends State<Destination_Home> {
  @override
  Widget build(BuildContext context) {
    DestinationProvider destinationProvider =
        Provider.of<DestinationProvider>(context);
    // final credential = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              children: [
                //  Header
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fly Freely and Comfortably ',
                              //  ${credential!.displayName} ',

                              style: blackTextStyle.copyWith(
                                  fontSize: 22, fontWeight: semiBold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Where to fly today ?',
                              style: greyTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: light,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //popular Destinations
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 323,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: destinationProvider.getPopularDestinations(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length, // error
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot ds =
                                    snapshot.data!.docs[index]; // error
                                HN_DestinatioModel destination =
                                    HN_DestinatioModel.fromDocument(ds);
                                // print(destination.toJson());
                                return DestinationCard(
                                    index: index,
                                    destinatioModel: destination,
                                    press: () {
                                      Navigator.pushNamed(
                                          context, DesDetailPage.id,
                                          arguments:
                                              DestinationArgument(destination));
                                    });
                              },
                            )
                          : const Center();
                    },
                  ),
                ),

                //New Destinations
                Container(
                  height: 27,
                  margin: const EdgeInsets.only(top: 20, left: 24, right: 24),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New This Year',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 323,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: destinationProvider.getNewDestinations(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              // padding:
                              //     const EdgeInsets.only(bottom: 10, top: 10),
                              itemCount: snapshot.data!.docs.length, // error
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot ds =
                                    snapshot.data!.docs[index]; // error
                                HN_DestinatioModel destination =
                                    HN_DestinatioModel.fromDocument(ds);
                                return DestinationCard(
                                    index: index,
                                    destinatioModel: destination,
                                    press: () {
                                      Navigator.pushNamed(
                                          context, DesDetailPage.id,
                                          arguments:
                                              DestinationArgument(destination));
                                    });
                              },
                            )
                          : const Center();
                    },
                  ),
                ),

                //Local Destinations
                Container(
                  height: 27,
                  margin: const EdgeInsets.only(top: 20, left: 24, right: 24),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Best Local Destinations',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                      top: 5, left: 24, right: 24, bottom: 20),
                  // height: ,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: destinationProvider.getLocalDestinations(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length, // error
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot ds =
                                    snapshot.data!.docs[index]; // error
                                HN_DestinatioModel destination =
                                    HN_DestinatioModel.fromDocument(ds);
                                return DestinationTile(
                                    index: index,
                                    destinatioModel: destination,
                                    press: () {
                                      Navigator.pushNamed(
                                          context, DesDetailPage.id,
                                          arguments:
                                              DestinationArgument(destination));
                                    });
                              },
                            )
                          : const Center();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
