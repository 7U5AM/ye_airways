import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ye_airways/model/ticket_ye_model.dart';
import 'package:ye_airways/provider/flight_provider.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTickets extends StatefulWidget {
  static const String id = 'UserTickets';

  const UserTickets({super.key});

  @override
  State<UserTickets> createState() => _UserTicketsState();
}

class _UserTicketsState extends State<UserTickets> {
  int? totalTicets;
  // int? seats;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // totalTicets = seats;
  }

  @override
  Widget build(BuildContext context) {
    FlightProvider flightProvider = Provider.of<FlightProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Your Tickets',
          style: whiteTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  totalTicets.toString(),
                  style: whiteTextStyle.copyWith(
                      fontSize: 18, fontWeight: semiBold),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.airplane_ticket,
                  size: 35,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: kbackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: const BoxDecoration(
                    // color: kbackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: flightProvider.getAllUserTicekts(),
                  builder: (context, AsyncSnapshot snapshot) {
                    totalTicets = snapshot.data.docs.length;
                    // totalTicets = snapshot.data!.docs.length;
                    // totalTicets = seats;
                    return snapshot.hasData
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 30),
                              itemCount: snapshot.data!.docs.length, // error
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot ds =
                                    snapshot.data!.docs[index]; // error
                                Ticket_YE_Model ticket =
                                    Ticket_YE_Model.fromDocument(ds);
                                // print(ticket.toJson());
                                // isOrder = product.usersCart.contains()
                                return TicketCard(
                                  index: index,
                                  ticket_model: ticket,
                                  press: () {},
                                );
                              },
                            ),
                          )
                        : const Center();
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
