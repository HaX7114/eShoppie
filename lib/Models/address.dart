import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/api_handler.dart';

class UserAddress {
  dynamic id;
  dynamic name;
  dynamic city;
  dynamic region;
  dynamic details;
  dynamic notes;
  dynamic latitude;
  dynamic longitude;

  UserAddress({
    this.id,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
    this.latitude,
    this.longitude,
  });

  UserAddress.fromJson(List<dynamic> data, List<UserAddress> addresses) {
    for (var element in data) {
      addresses.add(UserAddress(
        id: element['id'],
        name: element['name'],
        city: element['city'],
        region: element['region'],
        details: element['details'],
        notes: element['notes'],
        latitude: element['latitude'],
        longitude: element['longitude'],
      ));
    }
  }

  static Future<bool> deleteAddress(dynamic addressID) async {
    bool result = false;
    await APIHandler.dio!
        .delete(APIHandler.addresses + '/$addressID')
        .then((value) {
      //Then removing local data
      SharedHandler.removeSharedPref(SharedHandler.saveUserTokenKey);
      SharedHandler.removeSharedPref(SharedHandler.saveLoginKey);
      SharedHandler.removeSharedPref(SharedHandler.saveSetAddressKey);
      result = true;
    }).catchError((error) {});
    return result;
  }
}
