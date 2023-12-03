import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ye_airways/model/des_seats.dart';

class HN_DestinatioModel {
  String? desId;
  String? from;
  String? placename;
  String? to;
  String? description;
  double? rating;
  dynamic desImage;
  List<dynamic>? desOtherImages = [];
  String? desType;
// flights & tickets
  double? ticketPrice;
  String? date;
  String? time;
  String? duration;
  String? flightNumber;
  List<SeatModel>? seats = [];
  List<dynamic>? userSeats = [];

  //

  HN_DestinatioModel(
      {this.desId,
      this.to,
      this.placename,
      this.from,
      this.description,
      this.rating = 3.5,
      this.ticketPrice,
      this.desImage,
      this.desOtherImages,
      this.desType,
      this.date,
      this.time,
      this.duration,
      this.flightNumber,
      this.seats,
      this.userSeats});

  HN_DestinatioModel.fromJson(Map<String, dynamic> json) {
    desId = json["desId"];
    to = json["to"];
    placename = json["placename"];
    from = json["from"];
    description = json["description"];
    rating = json["rating"];
    ticketPrice = json["ticketPrice"];
    desImage = json["desImage"];
    desOtherImages = json["desOtherImages"] ?? [];
    desType = json["desType"];
    date = json["date"];
    time = json["time"];
    duration = json["duration"];
    flightNumber = json["flightNumber"];
    if (json["seats"] != null) {
      seats = [];
      json["seats"].forEach((seat) {
        seats!.add(SeatModel.fromJson(seat));
      });
    }
  }
  HN_DestinatioModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    desId = data["desId"];
    to = data["to"];
    placename = data["placename"];
    from = data["from"];
    description = data["description"];
    rating = data["rating"];
    ticketPrice = data["ticketPrice"];
    desImage = data["desImage"];
    desOtherImages = data["desOtherImages"] ?? [];

    desType = data["desType"];
    date = data["date"];
    time = data["time"];
    duration = data["duration"];
    flightNumber = data["flightNumber"];
    if (data["seats"] != null) {
      seats = [];
      data["seats"].forEach((seat) {
        seats!.add(SeatModel.fromJson(seat));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "desId": desId,
      "to": to,
      "placename": placename,
      "from": from,
      "description": description,
      "rating": rating,
      'ticketPrice': ticketPrice,
      "desImage": desImage,
      "desOtherImages": desOtherImages ?? [],
      "desType": desType,
      "date": date,
      "time": time,
      "duration": duration,
      "flightNumber": flightNumber,
      "seats": seats != null ? seats!.map((e) => e.toJson()).toList() : []
    };
  }
}
