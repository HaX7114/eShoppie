import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';

class IconInsideContainer extends StatelessWidget {
  final borderColor;
  final iconColor;
  final iconData;
  final iconSize;
  final size;

  const IconInsideContainer(
      {Key? key,
      this.borderColor = K_blackColor,
      this.size = 65.0,
      this.iconColor = K_goldColor,
      required this.iconData,
      this.iconSize = 32.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(K_radius - 5),
        border: Border.all(color: borderColor),
      ),
      child: Icon(iconData, color: iconColor, size: iconSize),
    );
  }
}
