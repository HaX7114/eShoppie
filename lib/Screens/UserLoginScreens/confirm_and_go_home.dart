import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_home.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class ConfirmAndGoHome extends StatelessWidget {
  const ConfirmAndGoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Center(
              child: Stack(
                children: [
                  Lottie.asset('lotties/fireworks.json'),
                  Lottie.asset('lotties/done.json', repeat: false),
                ],
              ),
            ),
            Expanded(child: Container()),
            MyText(
              text: "You're all set !",
              size: K_fontSizeL + 5,
            ),
            K_vSpace20,
            MyText(
              text: 'Thank you for joining eShoppie !',
              fontWeight: FontWeight.normal,
              size: K_fontSizeL - 2,
            ),
            K_vSpace20,
            MyButton(
              onPressed: () {
                navigateToWithReplace(context, UserHome());
              },
              fillColor: K_blackColor,
              text: 'Go to Shopping',
              textColor: K_goldColor,
              textSize: K_fontSizeL - 3,
              buttonWidth: double.infinity,
            ),
            K_vSpace20
          ],
        ),
      ),
    );
  }
}
