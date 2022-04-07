import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/material.dart';

class OnBoardingPageDesign extends StatelessWidget {
  final image;
  final title;
  final body;

  const OnBoardingPageDesign({Key? key, this.image, this.title, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          height: deviceHeight! * 0.8,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.2, 0.9])),
          child: Padding(
            padding: const EdgeInsets.all(K_mainPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(),
                  flex: 4,
                ),
                MyText(
                  text: title,
                  size: K_fontSizeL,
                  color: K_whiteColor,
                ),
                K_vSpace20,
                MyText(
                  text: body,
                  size: K_fontSizeL,
                  color: K_whiteColor,
                  fontWeight: FontWeight.normal,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
