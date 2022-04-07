import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';

showSnackBar(context, text, color, {icon, iconColor}) {
  return Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: K_blackColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.fixed,
      content: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 25.0,
            ),
            K_hSpace10,
            MyText(
              text: text,
              size: 15.0,
              color: color,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      )));
}
