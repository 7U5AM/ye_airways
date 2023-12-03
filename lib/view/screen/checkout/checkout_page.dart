import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/model/ticket_ye_model.dart';
import 'package:ye_airways/provider/flight_provider.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ye_airways/view/screen/checkout/success_checkout_page.dart';
import 'package:ye_airways/view/widgets/booking_details_item.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';

// ignore: must_be_immutable
class CheckoutPage extends StatefulWidget {
  CheckoutPage(
      {Key? key,
      required this.destination,
      required this.getTotalSeats,
      required this.ticketNumber})
      : super(key: key);
  final HN_DestinatioModel destination;
  final List<String>? getTotalSeats;
  String ticketNumber;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    FlightProvider flightProvider = Provider.of<FlightProvider>(context);
    Ticket_YE_Model ticketModel;

    String getSeat(List<String> listSeat) {
      String strr = "";
      for (int i = 0; i < listSeat.length; i++) {
        String str = listSeat[i];
        if (i == listSeat.length - 1) {
          strr += str;
        } else {
          strr += "$str, ";
        }
      }

      return strr;
    }

    dynamic getTotalPrice;
    int getTravelers;
    Widget route() {
      return Container(
        margin: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/sm_YE_logo.png')),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 291,
              height: 65,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image_checkout.png'))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.destination.from}',
                      style: blackTextStyle.copyWith(
                          fontSize: 24, fontWeight: semiBold),
                    ),
                    Text(
                      '${widget.destination.from}',
                      style: greyTextStyle.copyWith(fontWeight: light),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.destination.to}',
                      style: blackTextStyle.copyWith(
                          fontSize: 24, fontWeight: semiBold),
                    ),
                    Text(
                      '${widget.destination.to}',
                      style: greyTextStyle.copyWith(fontWeight: light),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    bool seatsOver = false;
    if (widget.getTotalSeats!.length <= 9) {
      seatsOver = false;
    } else {
      seatsOver = true;
    }

    Widget bookingDetails() {
      // getTotalSeats = widget.destination.userSeats;
      getTotalPrice =
          widget.destination.ticketPrice! * widget.getTotalSeats!.length;
      getTravelers = widget.getTotalSeats!.length;
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: kWhiteColor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //NOTE : DESTINATION TILE
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.destination.desImage)),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.destination.placename}',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('${widget.destination.to}',
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
                    '${widget.destination.rating}',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  )
                ],
              ),
            ],
          ),

          //NOTE : BOOKING DETAIL LIST
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              'Booking Details',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),

          //NOTE : BOOKING DETAILS ITEM
          BookingDetailsItem(
              title: 'Ticket No',
              valueText: widget.ticketNumber,
              valueColor: kBlackColor),
          BookingDetailsItem(
              title: 'Traveler',
              valueText: '${getTravelers.toString()} person',
              valueColor: kBlackColor),
          BookingDetailsItem(
              title: "Date",
              valueText: '${widget.destination.date}',
              valueColor: kBlackColor),
          BookingDetailsItem(
              title: "Take Off",
              valueText: ' ${widget.destination.time}',
              valueColor: kBlackColor),

          seatsOver
              ? Container(
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(
                  //       15,
                  //     )),
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    // underline: SizedBox(),
                    dropdownColor: kWhiteColor,
                    hint: Row(children: [
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icon_check.png')),
                        ),
                      ),
                      Text(
                          "Seats                                                 ",
                          style: blackTextStyle),
                      // Spacer(),
                      Text(
                        "",
                        style: blackTextStyle.copyWith(
                            fontWeight: semiBold, color: kBlackColor),
                      )
                    ]),
                    items: widget.getTotalSeats!.map((String dropDownItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownItem,
                        child: Text(
                          dropDownItem,
                          style: blackTextStyle.copyWith(
                              fontWeight: semiBold, color: kBlackColor),
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
                )
              : BookingDetailsItem(
                  title: 'Seats',
                  valueText: getSeat(widget.getTotalSeats!),
                  valueColor: kBlackColor),
          BookingDetailsItem(
              title: 'Insurance', valueText: 'YES', valueColor: kGreenColor),
          BookingDetailsItem(
              title: 'Refundable', valueText: 'NO', valueColor: kRedColor),
          // BookingDetailsItem(
          //     title: 'VAT', valueText: '10%', valueColor: kBlackColor),

          BookingDetailsItem(
              title: 'Total Price',
              valueText: '\$ $getTotalPrice',
              valueColor: kBlackColor),
          // BookingDetailsItem(
          //     title: 'Grand Total',
          //     valueText: '\$ ${widget.destination.ticketPrice! * 0.1}',
          //     valueColor: kPrimaryColor),
        ]),
      );
    }

    Widget paymentDetails() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: kWhiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Details',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 70,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image_card.png')),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/icon_plane.png'))),
                          ),
                          Text(
                            'Pay',
                            style: whiteTextStyle.copyWith(
                                fontSize: 16, fontWeight: medium),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$ ',
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Current Balance',
                          style: greyTextStyle.copyWith(fontWeight: light),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget payNowButton() {
      return CustomButton(
        title: 'Pay Now',
        onPressed: () async {
          ticketModel = Ticket_YE_Model(
            ticketNumber: widget.ticketNumber,
            from: widget.destination.from,
            to: widget.destination.to,
            date: widget.destination.date,
            travelers: widget.getTotalSeats!.length.toString(),
            time: widget.destination.time,
            duration: widget.destination.duration,
            desType: widget.destination.desType,
            flightNumber: widget.destination.flightNumber,
            ticketSeats: widget.getTotalSeats,
            totalprice: getTotalPrice,
          );
          await flightProvider.addUserTickets(
              ticketModel, widget.destination.desId!);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SuccessCheckoutPage()));
        },
        // margin: EdgeInsets.only(top: 30),
      );
    }

    Widget tacButton() {
      return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            top: 30,
            bottom: 30,
          ),
          child: Text(
            'Tearms and Conditions',
            style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
                decoration: TextDecoration.underline),
          ));
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            route(),
            bookingDetails(),
            paymentDetails(),
            payNowButton(),
            tacButton()
          ],
        ),
      ),
    );
  }
}
