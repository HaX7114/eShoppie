import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorApi {
  static Future<void> requestLocationPermission() async {
    await Geolocator.requestPermission();
  }

  static Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  static Future<void> setGeoCoderAddressToTextFields(
      double lat,
      double lng,
      dynamic streetController,
      dynamic governmentController,
      dynamic regionController) async {
    GeoCode geoCode = GeoCode();
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lng);
    streetController.text = address.streetAddress!;
    governmentController.text = address.region!;
    regionController.text = address.city!;
  }
}
