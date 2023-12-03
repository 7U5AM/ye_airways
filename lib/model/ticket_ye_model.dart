import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket_YE_Model {
  String? userId;
  String? userName;
  String? ticketNumber;
  String? from;
  //
  dynamic desImage;
  String? placename;
  double? rating;
//
  String? to;
  String? date;
  String? travelers;
  String? time;
  String? duration;
  String? flightNumber;
  String? desType;
  List<dynamic>? ticketSeats = [];
  dynamic totalprice;

  Ticket_YE_Model({
    this.userId,
    this.userName,
    this.ticketNumber,
    this.from,
    this.to,
    //
    this.desImage,
    this.placename,
    //
    this.date,
    this.travelers,
    this.time,
    this.duration,
    this.desType,
    this.flightNumber,
    this.ticketSeats,
    this.totalprice,
  });

  Ticket_YE_Model.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    userName = json["userName"];
    ticketNumber = json["ticketNumber"];
    from = json["from"];
    to = json["to"];
    date = json["date"];
    travelers = json["travelers"];
    time = json["time"];
    duration = json["duration"];
    desType = json["desType"];
    flightNumber = json["flightNumber"];
    ticketSeats = json["ticketSeats"] ?? [];
    totalprice = json["totalprice"];
  }

  Ticket_YE_Model.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;

    userId = data["userId"];
    userName = data["userName"];
    ticketNumber = data["ticketNumber"];
    from = data["from"];
    to = data["to"];
    date = data["date"];
    travelers = data["travelers"];
    time = data["time"];
    duration = data["duration"];
    desType = data["desType"];
    flightNumber = data["flightNumber"];
    ticketSeats = data["ticketSeats"] ?? [];
    totalprice = data["totalprice"];
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "ticketNumber": ticketNumber,
      "from": from,
      "to": to,
      "date": date,
      'travelers': travelers,
      "time": time,
      "duration": duration,
      "desType": desType,
      "flightNumber": flightNumber,
      "ticketSeats": ticketSeats ?? [],
      "totalprice": totalprice,
    };
  }
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket_YE_Model {
  String? ticketNumber;
  String? from;
  String? placename;

  String? to;
  String? date;
  String? travelers;
  // String? bookingClass;
  String? time;
  String? duration;
  String? flightNumber;
  List<dynamic>? ticketSeats = [];
  dynamic totalprice;
  // String? gateNumber;
  // String? user;

  Ticket_YE_Model({
    this.ticketNumber,
    this.from,
    this.to,
    this.date,
    // this.returnDate,
    this.travelers,
    // this.bookingClass,
    this.time,
    this.duration,
    this.flightNumber,
    this.ticketSeats,
    this.totalprice,
    // this.gateNumber,
    // this.user
    // this.mytickets,
  });

  Ticket_YE_Model.fromJson(Map<String, dynamic> json) {
    ticketNumber = json["ticketNumber"];

    from = json["from"];
    to = json["to"];
    date = json["date"];
    // returnDate = json["returnDate"]?? "";
    travelers = json["travelers"];
    // bookingClass = json["time"]?? "";
    duration = json["duration"];
    flightNumber = json["flightNumber"];
    ticketSeats = json["ticketSeats"] ?? [];
    totalprice = json["totalprice"];
    // gateNumber = json["gateNumber"]?? "";
    // user = json["user"];
    // mytickets = json["mytickets"] ?? [];
  }
  Ticket_YE_Model.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    ticketNumber = data["ticketNumber"];

    from = data["from"];
    to = data["to"];
    date = data["date"];
    travelers = data["travelers"];
    // bookingClass = data["time"]?? "";
    duration = data["duration"];
    flightNumber = data["flightNumber"];
    ticketSeats = data["ticketSeats"] ?? [];
    totalprice = data["price"];
    // gateNumber = data["gateNumber"]?? "";
    // user = data["user"];
    // mytickets = data["mytickets"] ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      "ticketNumber": ticketNumber,
      "from": from,
      "to": to,
      "date": date,
      'travelers': travelers,
      // "bookingClass": bookingClass?? "",
      "duration": duration,
      "flightNumber": flightNumber,
      "ticketSeats": ticketSeats ?? [],
      "totalprice": totalprice,
      // "gateNumber": gateNumber?? "",
      // "user": user
    };
  }
}

*/
