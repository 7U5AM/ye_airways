import 'package:ye_airways/model/ticket_ye_model.dart';
import 'package:ye_airways/shared/components/components.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/widgets/custom_horizontal_divider.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final int index;
  final Ticket_YE_Model ticket_model;
  final Function()? press;

  const TicketCard(
      {super.key,
      required this.index,
      required this.ticket_model,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CheckoutPage(
        //               destination: ticket_model,
        //             )));
        // Navigator.pushNamed(context, Seat_YE_Screen.id);
      },
      child: Column(
        children: [
          // route(),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                    bottom: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5.0),
                          AcronymCustomText(
                              text: ticket_model.from!
                                  .substring(0, 3)
                                  .toUpperCase()),
                          const SizedBox(height: 5.0),
                          ActiveInfoCustomText(
                            text: ticket_model.from,
                            // color: kPrimaryColor,
                          ),
                          const SizedBox(height: 20.0),
                          const InactiveInfoCustomText(
                            text: 'FLIGHT NO',
                          ),
                          const SizedBox(height: 5.0),
                          ActiveInfoCustomText(
                            text: ticket_model.flightNumber,
                            //     '${ticket_model.flightNumber}',
                            // color: kPrimaryColor,
                          ),
                          const SizedBox(height: 10.0),
                          const InactiveInfoCustomText(text: 'DATE'),
                          const SizedBox(height: 5.0),
                          ActiveInfoCustomText(
                            text: ticket_model.date,
                            // color: secondaryTextColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 80.0,
                            width: 120.0,
                            child:
                                Image(image: AssetImage('assets/logo-ye.png')),
                          ),
                          const InactiveInfoCustomText(text: 'Travelers'),
                          const SizedBox(height: 5.0),
                          ActiveInfoCustomText(
                            text: ticket_model.travelers,
                          ),
                          const SizedBox(height: 10.0),
                          const InactiveInfoCustomText(text: 'Duration'),
                          const SizedBox(height: 5.0),
                          ActiveInfoCustomText(
                            text: ticket_model.duration,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 5.0),
                          AcronymCustomText(
                            text:
                                ticket_model.to!.substring(0, 3).toUpperCase(),
                          ),
                          const SizedBox(height: 5.0),
                          ActiveInfoCustomText(
                            text: ticket_model.to,

                            // text: ticket_model.to,
                            // color: kDateTimeAndCitesColor,
                          ),
                          const SizedBox(height: 20.0),
                          const InactiveInfoCustomText(
                            text: 'TICKET NO',
                          ),
                          const SizedBox(height: 5.0),
                          ActiveInfoCustomText(
                            text: ticket_model.ticketNumber,
                            //     '${ticket_model.flightNumber}',
                            // color: kActiveColor,
                          ),
                          const SizedBox(height: 10.0),
                          const InactiveInfoCustomText(text: 'TIME'),
                          const SizedBox(height: 5),
                          ActiveInfoCustomText(
                            text: ticket_model.time,
                            // color: kActiveColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomHorizontalDivider(),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 8.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 30.0,
                        width: 100.0,
                        child: Image(
                          // width: 150,
                          image: AssetImage(
                            'assets/barcode.png',
                          ),
                          // image: AssetImage('assets/bottom_logos.png'),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'PRICE:',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "\$${ticket_model.totalprice}",
                              // '\$ ${ticket_model.ticketPrice}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
