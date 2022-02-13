import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler {
  static SharedPreferences? sharedPrefInstance;

  static String saveOnBoardingKey = 'SavedOnBoarding';

  static String saveLoginKey = 'SavedLogin';

  static String saveUserTokenKey = 'Token';

  static initSharedPref() async {
    await SharedPreferences.getInstance().then((value) {
      sharedPrefInstance = value;
      print('Shared Initialized');
    });
  }

  static getSharedPref(String key) {
    try {
      dynamic sharedValue = sharedPrefInstance!.get(key);
      if (sharedValue.runtimeType.toString() == 'Null') {
        return false; //false means there is no saved in shared preference
      } else {
        return sharedValue;
      }
    } catch (error) {
      return false;
    }
  }

  static Future<bool> setSharedPref(String key, dynamic value) async {
    bool isSetPref = false;
    print('THIS IS THE VALUE RUN TIME TYPE : ' + value.runtimeType.toString());

    switch (value.runtimeType) {
      case int:
        isSetPref = await sharedPrefInstance!.setInt(key, value);
        break;
      case double:
        isSetPref = await sharedPrefInstance!.setDouble(key, value);
        break;
      case bool:
        isSetPref = await sharedPrefInstance!.setBool(key, value);
        break;
      default:
        isSetPref = await sharedPrefInstance!.setString(key, value);
        break;
    }

    return isSetPref;
  }

  static removeSharedPref(String key) => sharedPrefInstance!.remove(key);

  static clearSharedPref() => sharedPrefInstance!.clear();
}
