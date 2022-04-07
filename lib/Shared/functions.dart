import 'package:eshoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_home.dart';
import 'package:eshoppie/Screens/UserLoginScreens/get_user_address.dart';
import 'package:eshoppie/Screens/UserLoginScreens/login.dart';
import 'package:eshoppie/Screens/UserLoginScreens/on_boarding.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/api_handler.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Navigation functions
navigateTo(context, page, {transition}) {
  Navigator.push(
    context,
    PageTransition(
      type: transition ?? PageTransitionType.rightToLeftWithFade,
      child: page,
      reverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 500),
    ),
  );
}

navigateToWithReplace(context, page, {transition}) {
  Navigator.pushReplacement(
    context,
    PageTransition(
        type: transition ?? PageTransitionType.rightToLeftWithFade,
        child: page,
        duration: const Duration(milliseconds: 400)),
  );
}

navigateBack(context) {
  Navigator.pop(context);
}

//Toaster function

void showToastMessage(String msg, {dynamic color, dynamic textColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color ?? K_whiteColor,
    textColor: textColor ?? K_blackColor,
    fontSize: K_fontSizeL - 5,
  );
}

//Shared preferences functions

saveOnBoardingInShared() async {
  await SharedHandler.setSharedPref(SharedHandler.saveOnBoardingKey, true);
  print('on boarding saved');
}

saveLoginInShared() async {
  await SharedHandler.setSharedPref(SharedHandler.saveLoginKey, true);
  print('Login saved');
}

//decide what the user will see when he access the application
userFirstPage() {
  dynamic isSkippedOnBoarding =
      SharedHandler.getSharedPref(SharedHandler.saveOnBoardingKey);
  dynamic isSkippedAddress =
      SharedHandler.getSharedPref(SharedHandler.saveSetAddressKey);
  dynamic isSkippedLogin =
      SharedHandler.getSharedPref(SharedHandler.saveLoginKey);

  if (isSkippedOnBoarding) {
    if (isSkippedAddress) {
      return UserHome();
    } else {
      return Login();
    }
  } else {
    return const OnBoarding(); //Go to onBoarding page
  }
}

Widget showHomePageOrGetAddressAfterLogin() {
  dynamic isSkippedAddress =
      SharedHandler.getSharedPref(SharedHandler.saveSetAddressKey);
  if (isSkippedAddress) {
    return UserHome();
  } else {
    return const GetUserAddress();
  }
}

//PopScope
Future<bool> onPoping() {
  if (EasyLoading.isShow) {
    return Future.value(false);
  } else {
    return Future.value(true);
  }
}
