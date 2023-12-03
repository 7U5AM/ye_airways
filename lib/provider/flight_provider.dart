import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ye_airways/model/ticket_ye_model.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:flutter/material.dart';

// h
class FlightProvider with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference ticketsRef =
      FirebaseFirestore.instance.collection("userTickets");
  // .doc(userFireData.uid)
  // .collection("${user.email}");

  // CollectionReference ticketsRef =
  //     FirebaseFirestore.instance.collection("userTickets");

  // CollectionReference ticketsRef =
  //     FirebaseFirestore.instance.collection("userTickets");

  final storageRef = FirebaseStorage.instance.ref();
  // double alltotalPrice = 0;
  // double get totalPrice => alltotalPrice;

  getAllUserTicekts() {
    User? user3 = FirebaseAuth.instance.currentUser;

    if (user3!.uid == uid) {
      CollectionReference ticketDesRef = FirebaseFirestore.instance
          .collection("userTickets")
          .doc(uid)
          .collection(user3.email!);

      return ticketDesRef.snapshots();
    } else {
      return const AlertDialog(
        // actions: [],
        title: Text("There is an Error!"),
        content: Text("Try Again Later"),
      );
    }
  }

  // getAllTickets() {
  //   return ticketsRef.doc(user!.uid).collection(user!.email!).snapshots();
  // }

  getAllTicketsCart() {
    User? user = FirebaseAuth.instance.currentUser;
    return ticketsRef
        .where(
          "usersCart",
          arrayContains: user!.uid,
        )
        .snapshots();
  }

  addUserTickets(Ticket_YE_Model objTicket, String desID) async {
    User? user2 = FirebaseAuth.instance.currentUser;
    CollectionReference destinationRef =
        FirebaseFirestore.instance.collection("destinations");
    objTicket.userId = user2!.uid;
    objTicket.userName = user2.displayName;

    CollectionReference ticketsRef = FirebaseFirestore.instance
        .collection("userTickets")
        .doc(user2.uid)
        .collection("${user2.email}");
    await destinationRef
        .doc(desID)
        .collection("destTickets")
        .doc(objTicket.ticketNumber)
        .set(objTicket.toJson());

    return await ticketsRef.doc(desID).set(objTicket.toJson());
  }

  chechTicketNumber(Ticket_YE_Model ticket, String desID) async {
    User? user2 = FirebaseAuth.instance.currentUser;
    CollectionReference ticketsRef = FirebaseFirestore.instance
        .collection("userTickets")
        .doc(user2!.uid)
        .collection("${user2.email}");
    if (ticketsRef.doc(desID) == desID) {}
    await ticketsRef.doc(ticket.ticketNumber).set(ticket.toJson());
  }

  deleteTicket(String id) async {
    await ticketsRef.doc(id).delete();
  }

  updateTicketinationToCart(Ticket_YE_Model ticket) async {
    await ticketsRef.doc(ticket.ticketNumber).set(ticket.toJson());
  }

  // setTotalPriceCart(double value) {
  //   alltotalPrice = value;

  //   //  notifyListeners();
  // }

  // getTotalPrice() {
  //   return totalPrice;

  //   // notifyListeners();
  // }
}
