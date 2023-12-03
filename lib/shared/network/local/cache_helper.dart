
import 'package:shared_preferences/shared_preferences.dart';

class CacheHlper{

 static late  SharedPreferences sharedPreferences;

static init() async{
  sharedPreferences= await SharedPreferences.getInstance();
}

static Future<bool> putData(
  {
   required String key,
   required dynamic value,
  }
){
if(value is bool) return  sharedPreferences.setBool(key, value);
else if(value is double)   return  sharedPreferences.setDouble(key,double.parse(value.toString()));
else if(value is int) return  sharedPreferences.setInt(key, value);
else return  sharedPreferences.setString(key, value.toString());
}

static dynamic getData(
  {
    required String key,
  }
)
{
 return sharedPreferences.get(key);
}


static Future<bool> removeData({
    required String key,
  }) async
  {
    return await sharedPreferences.remove(key);
  }
}