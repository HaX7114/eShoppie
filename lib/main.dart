import 'package:eShoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eShoppie/Screens/UserLoginScreens/login.dart';
import 'package:eShoppie/Screens/UserLoginScreens/on_boarding.dart';
import 'package:eShoppie/Shared/functions.dart';
import 'package:eShoppie/Shared/shared_preference.dart';
import 'package:eShoppie/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AppCubits/block_observer.dart';
import 'MyWidgets/my_theme_data.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eShoppie',
      debugShowCheckedModeBanner: false,
      theme: myThemeData(),
      home: userFirstPage(),
    );
  }
}
