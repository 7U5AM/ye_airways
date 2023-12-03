class UserSeateModel {
  String? seatNo;

  UserSeateModel({this.seatNo});

  UserSeateModel.fromJson(Map<String, dynamic> json) {
    seatNo = json["seatNo"] ?? "";
  }
  Map<String, dynamic> toJson() {
    return {"column": seatNo ?? ""};
  }
}
