import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {"Content-Type": "application/json"}));
  }

  static Future<Response> getData(
      {required String path,  Map<String, dynamic>? query,String? token,String lang="en"}) async {
   dio.options.headers = {"lang": lang,
   "Authorization":token,
   "Content-Type": "application/json"};
    return await dio.get(path, queryParameters: query);
  }

  static Future<Response> getPost(
      {required String path,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,String? token,String lang="ar"}) async {
     dio.options.headers = {"lang": lang,
   "Authorization":token,
   "Content-Type": "application/json"};
    return await dio.post(path, queryParameters: query, data: data);
  }
}
