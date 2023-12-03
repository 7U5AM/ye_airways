class SeatModel {
  String? desId;
  String? column;
  String? userId;
  String? state;

  SeatModel({this.desId, this.column, this.userId, this.state});

  SeatModel.fromJson(Map<String, dynamic> json) {
    desId = json["desId"] ?? "";
    column = json["column"] ?? "";
    userId = json["userId"] ?? "";
    state = json["state"] ?? "0";
  }
  Map<String, dynamic> toJson() {
    return {
      "desId": desId ?? "",
      "column": column ?? "",
      "userId": userId ?? "",
      "state": state ?? "0"
    };
  }
}
