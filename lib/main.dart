import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/Screens/UserLoginScreens/login.dart';
import 'package:eshoppie/Screens/UserLoginScreens/on_boarding.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'AppCubits/block_observer.dart';
import 'MyWidgets/my_theme_data.dart';
import 'package:device_preview/device_preview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

double? deviceHeight; //Gets the device height via media query
double? deviceWidth; //Gets the device width via media query

String userTokenWhileSession =
    ''; //This will be used in any functions that uses the token to get or post data on the server

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  APIHandler.initializeAPI();
  await SharedHandler.initSharedPref();
  //Get THE Autoriaztion token value to be able to make any transactions which use it
  userTokenWhileSession = APIHandler.dio!.options.headers.update(
      APIHandler.authKey,
      (value) => SharedHandler.getSharedPref(SharedHandler.saveUserTokenKey)
          .toString());
  Bloc.observer = MyBlocObserver();

  print(SharedHandler.getSharedPref(SharedHandler.saveUserTokenKey));

  runApp(
    const MyApp(),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'eShoppie',
      debugShowCheckedModeBanner: false,
      theme: myThemeData(),
      home: userFirstPage(),
    );
  }
}
