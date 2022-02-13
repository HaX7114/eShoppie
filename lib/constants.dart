import 'package:flutter/material.dart';

//Colors
const Color K_whiteColor = Color(0XFFFFFFFF);
const Color K_blackColor = Color(0XFF000000);
const Color K_offWhiteColor = Color(0XFFF8F9FF);
const Color K_transparentColor = Colors.transparent;
const Color K_greyColor = Colors.white30;

//Spaces
const SizedBox K_hSpace10 = SizedBox(
  width: 10.0,
);
const SizedBox K_vSpace10 = SizedBox(
  height: 10.0,
);
const SizedBox K_hSpace20 = SizedBox(
  width: 20.0,
);
const SizedBox K_vSpace20 = SizedBox(
  height: 20.0,
);

//Doubles
const double K_fontSizeM = 15.0;
const double K_fontSizeL = 20.0;
const double K_radius = 20.0;
const double K_mainPadding = 20.0;

//Progress Indicator
const Widget K_progressIndicator = Center(
    child: CircularProgressIndicator(
  color: K_blackColor,
  strokeWidth: 5.0,
));
//Shadows
dynamic shadow = [const BoxShadow(color: Colors.black12, blurRadius: 20.0)];
