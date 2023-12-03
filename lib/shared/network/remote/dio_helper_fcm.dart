import 'package:dio/dio.dart';

class DioHelperFCM {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://fcm.googleapis.com/fcm/",
        receiveDataWhenStatusError: true,
        headers: {"Content-Type": "application/json",
        "Authorization":"key=AAAArH4lHZ4:APA91bGiNHQUEQeKrL7d9fLKn6YSmERmkL6-otiv104_EQu570GZwUozk2SJM7Od3CSdpHgLU10AxMzIvHFWnih8wgzohWtXVZrceKh24B5uM14Qq2uNIHSKPN8Ho7TSXjG_fYkOn8YW"}));
  }


  static Future<Response> sendNotification(
   {required String to,
   required String body,
   required String title,
   }
  ) async {
    return await dio.post("send",  data: {
 "to" : to,
 "notification" : {
     "body" : body,
     "title": title,
     "sound": "default"
 }

});
  }
}
