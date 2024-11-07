import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late  SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  })
  {
    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    }
    else if(value is List)
      {
        return sharedPreferences.setStringList(key, value as List<String>);
      }
    else  {
      return sharedPreferences.setDouble(key, value);

    }
  }
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static List<String> getListData({
    required String key,
  }) {
    return sharedPreferences.getStringList(key)??[];
  }

  static Future<bool> removeData({
    required String key,
})async
  {
   return await sharedPreferences.remove(key);
  }
}


class CacheHelperKeys {
  static const String ordersHistory = 'ordersHistory';
  static const String createCustomer = 'createCustomer';
}