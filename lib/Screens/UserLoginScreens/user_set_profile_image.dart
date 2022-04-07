import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class UserSetProfileImage extends StatelessWidget {
  const UserSetProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: K_whiteColor.withOpacity(0.8),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            navigateBack(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: K_blackColor,
            size: 28.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: 'Welcome to eShoppie',
              size: K_fontSizeL + 4,
            ),
            MyText(
              text: 'Setting your profile picture',
              fontWeight: FontWeight.normal,
              size: K_fontSizeL,
            ),
            Expanded(child: Container()),
            Center(
              child: Lottie.asset('lotties/profilepic.json',
                  frameRate: FrameRate(60.0)),
            ),
            Expanded(child: Container()),
            MyText(
              text: 'It will be very nice to add a profile picture of you !',
              size: K_fontSizeL - 2,
            ),
            K_vSpace20,
            MyText(
              text:
                  'Click choose image to set your profile image or skip this step for now.',
              fontWeight: FontWeight.normal,
              size: K_fontSizeL - 2,
            ),
            K_vSpace20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyButton(
                    onPressed: () {},
                    fillColor: Colors.transparent,
                    text: 'Skip',
                    textColor: K_blackColor,
                    textSize: K_fontSizeL - 3,
                    buttonWidth: double.infinity,
                  ),
                ),
                const Expanded(
                  child: K_vSpace20,
                ),
                Expanded(
                  flex: 2,
                  child: MyButton(
                    onPressed: () {},
                    fillColor: K_blackColor,
                    text: 'Choose image',
                    textColor: K_goldColor,
                    textSize: K_fontSizeL - 3,
                    buttonWidth: double.infinity,
                  ),
                ),
              ],
            ),
            K_vSpace20
          ],
        ),
      ),
    );
  }
}
