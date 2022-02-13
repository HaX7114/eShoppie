import 'package:eShoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eShoppie/Screens/UserHomeScreens/user_home.dart';
import 'package:eShoppie/Screens/UserLoginScreens/login.dart';
import 'package:eShoppie/Screens/UserLoginScreens/on_boarding.dart';
import 'package:eShoppie/Shared/shared_preference.dart';
import 'package:eShoppie/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//Navigation functions
navigateTo(context, page, {transition}) {
  Navigator.push(
    context,
    PageTransition(
      type: transition ?? PageTransitionType.rightToLeft,
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
        type: transition ?? PageTransitionType.rightToLeft,
        child: page,
        duration: const Duration(milliseconds: 400)),
  );
}

navigateBack(context) {
  Navigator.pop(context);
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
  dynamic isSkippedLogin =
      SharedHandler.getSharedPref(SharedHandler.saveLoginKey);

  if (isSkippedOnBoarding) {
    if (isSkippedLogin) {
      return UserHome(); //Go to home page
    } else {
      return Login(); //Go to login page
    }
  } else {
    return const OnBoarding(); //Go to onBoarding page
  }
}
