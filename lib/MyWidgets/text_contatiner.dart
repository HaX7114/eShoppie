import 'package:animate_do/animate_do.dart';
import 'package:eshoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer(
      {Key? key,
      required this.text,
      required this.color1,
      required this.color2,
      required this.icon})
      : super(key: key);

  final String text;
  final dynamic color1;
  final dynamic color2;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color1,
            radius: 27.0,
            child: CircleAvatar(
              backgroundColor: color2,
              radius: 18.0,
              child: Icon(
                icon,
                color: K_whiteColor,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0),
            child: MyText(
              text: text,
              size: K_fontSizeL - 2,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
