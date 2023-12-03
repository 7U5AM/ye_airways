import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ye_airways/model/ticket_ye_model.dart';

class HN_UserModel {
  String? id;
  String? userName;
  String? email;
  String? pass;
  String? phone;
  String? imgPath;

  double? balance;

  HN_UserModel({
    this.id,
    this.userName,
    this.email,
    this.pass,
    this.phone,
    this.imgPath,
    // this.usersCart,
    // this.quantityCart,
    this.balance,
    // this.location,
    // this.mytickets,
  });

  HN_UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userName = json["userName"];
    email = json["email"];
    pass = json["pass"];
    phone = json["phone"];
    imgPath = json["imgPath"];
    // usersCart = json["usersCart"] ?? [];
    // quantityCart = json["quantityCart"];
    //
    balance = json["balance"];
    // location = json["location"];
    // mytickets = json["mytickets"] ?? [];
  }
  HN_UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    id = data["id"];
    userName = data["userName"];
    email = data["email"];
    pass = data["pass"];
    phone = data["phone"];
    imgPath = data["imgPath"];
    // usersCart = data["usersCart"] ?? [];
    // quantityCart = data["quantityCart"];
    //
    balance = data["balance"];
    // location = data["location"];
    // mytickets = data["mytickets"] ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "pass": pass,
      'phone': phone,
      "imgPath": imgPath,
      "balance": balance,
      // "usersCart": usersCart ?? [],
      // "quantityCart": quantityCart,
      // "location": location,
      // "mytickets": mytickets ?? [],
    };
  }
}
