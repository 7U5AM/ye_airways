import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/model/des_seats.dart';
import 'package:ye_airways/model/ticket_ye_model.dart';
import 'package:flutter/material.dart';

// h

class DestinationProvider with ChangeNotifier {
  CollectionReference destinationRef =
      FirebaseFirestore.instance.collection("destinations");
  CollectionReference UsersCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference ticketDesRef =
      FirebaseFirestore.instance.collection("userTickets");

  final storageRef = FirebaseStorage.instance.ref();

  getUserSeats(HN_DestinatioModel desSeats, String userID) {
    List<String> showTicketSeats = [];
    var usr = FirebaseAuth.instance.currentUser;
    if (usr!.uid == userID) {
      for (int index = 0; index < desSeats.seats!.length; index++) {
        if (!showTicketSeats.contains(desSeats.seats![index].column) &&
            desSeats.seats![index].userId == userID &&
            desSeats.seats![index].state == "1") {
          showTicketSeats.add(desSeats.seats![index].column!);
        } else if (showTicketSeats.contains(desSeats.seats![index].column) &&
            desSeats.seats![index].userId != userID &&
            desSeats.seats![index].state == "0") {
          showTicketSeats.remove(desSeats.seats![index].column!);
        }
      }
      return showTicketSeats;
    }
  }

  getDestinaion(String destId) {
    return destinationRef.where("desId", isEqualTo: destId).snapshots();
  }

  getAllDestinations() {
    return destinationRef.snapshots();
  }

  getPopularDestinations() {
    return destinationRef
        .where("desType",
            isEqualTo: "Popular") // .orderBy("desId", descending: true)
        .snapshots();
  }

  getLocalDestinations() {
    return destinationRef.where("desType", isEqualTo: "Local").snapshots();
  }

  getNewDestinations() {
    return destinationRef.where("desType", isEqualTo: "New").snapshots();
  }

  Future<String> uploadImage(File file, String id, int indexImage) async {
    final mountainsRef = storageRef.child("desImage");
    final desImages = mountainsRef.child(id);

    await desImages.child("${id + indexImage.toString()}.jpg").putFile(file);
    return await desImages
        .child("${id + indexImage.toString()}.jpg")
        .getDownloadURL();
  }

  Future<String?> uploadOthersImage(
      File file, String id, int indexImage) async {
    final mountainsRef = storageRef.child("desImage");
    final desImages = mountainsRef.child(id);

    await desImages.child("$id.jpg").putFile(file);
    return await desImages.child("$id.jpg").getDownloadURL();
  }

  String getColumn(int col) {
    if (col == 1) {
      return "A";
    } else if (col == 2) {
      return "B";
    } else if (col == 3) {
      return "C";
    } else {
      return "D";
    }
  }

  addDestination(HN_DestinatioModel dest) async {
    String id = destinationRef.doc().id;
    dest.desId = id;
    for (int col = 1; col < 5; col++) {
      for (int row = 1; row < 9; row++) {
        SeatModel seatModel = SeatModel();
        seatModel.desId = dest.desId;
        seatModel.column = getColumn(col) + row.toString();
        dest.seats!.add(seatModel);
      }
    }
    if (dest.desImage != null) {
      List<String> listimages = [];
      dest.desImage = await uploadImage(
          dest.desImage, dest.desId!, dest.desOtherImages!.length);
      for (int i = 0; i < dest.desOtherImages!.length; i++) {
        listimages
            .add(await uploadImage(dest.desOtherImages![i], dest.desId!, i));
      }
      dest.desOtherImages = listimages;
      // destination.image = 'default';
      return await destinationRef.doc(id).set(dest.toJson());
    } else {
      dest.desImage = 'default';
      for (int i = 0; i < dest.desOtherImages!.length; i++) {
        dest.desOtherImages![i] =
            await uploadImage(dest.desOtherImages![i], dest.desId!, i);
      }
      return await destinationRef.doc(id).set(dest.toJson());
    }
  }

  updateDestination(HN_DestinatioModel dest) async {
    await destinationRef.doc(dest.desId).set(dest.toJson());
  }

  deleteDestination(String id) async {
    await destinationRef.doc(id).delete();
  }

  addUserTickets(Ticket_YE_Model objTicket, String desID) async {
    User? user2 = FirebaseAuth.instance.currentUser;

    CollectionReference ticketDesRef = FirebaseFirestore.instance
        .collection("userTickets")
        .doc(user2!.uid)
        .collection("${user2.email}");
    return await ticketDesRef.doc(desID).set(objTicket.toJson());
  }

  updateDestinationToCart(HN_DestinatioModel dest) async {
    await destinationRef.doc(dest.desId).set(dest.toJson());
  }
}
