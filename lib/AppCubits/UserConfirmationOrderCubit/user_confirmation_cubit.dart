import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_states.dart';
import 'package:eshoppie/Models/address.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/api_handler.dart';
import 'package:eshoppie/geo_locator_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class UserConfirmationCubit extends Cubit<UserConfirmationStates> {
  UserConfirmationCubit() : super(InitConfirmationState());

  static UserConfirmationCubit get(context) => BlocProvider.of(context);

  bool isCashPayment = true;

  changePaymentContainerColor() {
    isCashPayment = !isCashPayment;
    //True means cash | false means pay  with credit card
    emit(ChangePaymentState());
  }

  //Delivery address
  TextEditingController streetController = TextEditingController();
  TextEditingController governmentController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  Position? position;
  bool isSavingNow = false;
  bool isSavedAddress = false;

  UserAddress address = UserAddress(
      id: 0,
      details: 'Street',
      city: 'City',
      region: 'Region',
      latitude: 0.0,
      longitude: 0.0,
      name: 'HOME',
      notes: 'HOME');

  setUserAddressDefaultData() {
    if (!SharedHandler.getSharedPref(SharedHandler.saveSetAddressKey)) {
      address = UserAddress(
          id: 0,
          details: 'Street',
          city: 'City',
          region: 'Region',
          latitude: 0.0,
          longitude: 0.0,
          name: 'HOME',
          notes: 'HOME');
    } else {
      address = UserAddress(
          id: SharedHandler.getSharedPref(SharedHandler.saveAddressIDKey),
          details: SharedHandler.getSharedPref(SharedHandler.saveStreetKey),
          city: SharedHandler.getSharedPref(SharedHandler.saveCityKey),
          region: SharedHandler.getSharedPref(SharedHandler.saveRegionKey),
          latitude: SharedHandler.getSharedPref(SharedHandler.saveLatKey),
          longitude: SharedHandler.getSharedPref(SharedHandler.saveLngKey),
          name: '',
          notes: '');
    }
  }

  setNewAddressFromTextFields() {
    address.details = streetController.text.trim();
    address.region = regionController.text.trim();
    address.city = governmentController.text.trim();
    setStateToGotAddressState();
  }

  getLocationByGeo() async {
    await GeoLocatorApi.requestLocationPermission();
    position = await GeoLocatorApi.getCurrentLocation();
    await GeoLocatorApi.setGeoCoderAddressToTextFields(
        position!.latitude,
        position!.longitude,
        streetController,
        governmentController,
        regionController);
    //Save lat and lng into address
    address.latitude = position!.latitude;
    address.longitude = position!.longitude;
    setNewAddressFromTextFields();
  }

  saveAddressOfUser() {
    emit(SavingAddressState());
    isSavingNow = true;
    APIHandler.dio!.post(
      APIHandler.addresses,
      data: {
        "name": address.name,
        "city": address.city,
        "region": address.region,
        "details": address.details,
        "latitude": address.latitude,
        "longitude": address.longitude,
        "notes": address.notes
      },
    ).then((value) async {
      await saveAddressOfUserLocally(value.data['data']['id']);
      isSavedAddress = true;
      emit(SavedAddressState());
    }).catchError((error) {
      emit(ErrorSavingAddressState());
    });
  }

  updateAddressOfUser() {
    emit(SavingUpdatedAddressState());

    APIHandler.dio!.put(
      APIHandler.addresses + '/${address.id}',
      data: {
        "name": "HOME",
        "city": address.city,
        "region": address.region,
        "details": address.details,
        "latitude": address.latitude,
        "longitude": address.longitude,
        "notes": "HOME"
      },
    ).then((value) async {
      await updateAddressOfUserLocally();
      emit(SavedUpdatedAddressState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSavingUpdateAddressState());
    });
  }

  saveAddressOfUserLocally(dynamic addressID) async {
    await SharedHandler.setSharedPref(
        SharedHandler.saveAddressIDKey, addressID);
    await SharedHandler.setSharedPref(SharedHandler.saveCityKey, address.city);
    await SharedHandler.setSharedPref(
        SharedHandler.saveRegionKey, address.region);
    await SharedHandler.setSharedPref(
        SharedHandler.saveStreetKey, address.details);
    await SharedHandler.setSharedPref(SharedHandler.saveSetAddressKey,
        true); //Save that the user has been saved his address on the server and locally
  }

  updateAddressOfUserLocally() async {
    await SharedHandler.setSharedPref(SharedHandler.saveCityKey, address.city);
    await SharedHandler.setSharedPref(
        SharedHandler.saveRegionKey, address.region);
    await SharedHandler.setSharedPref(
        SharedHandler.saveStreetKey, address.details);
  }

  setStateToGettingLocationState() {
    emit(SetGettingLocationState());
  }

  setStateToGotAddressState() {
    emit(SetGotAddressState());
  }

  setStateToErrorAddressState() {
    emit(ErrorGettingAddressState());
  }

  //
}
