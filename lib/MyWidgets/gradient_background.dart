import 'dart:ui';

import 'package:eShoppie/constants.dart';
import 'package:eShoppie/main.dart';
import 'package:flutter/material.dart';


class GradientBackground extends StatelessWidget {

  final childWidget;
  final firstColor;
  final secondColor;

  const GradientBackground({Key? key,required this.childWidget,this.firstColor,this.secondColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: deviceHeight,
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [firstColor ?? Colors.orange.withOpacity(0.2),secondColor ?? Colors.white.withOpacity(0.1)],
                  focal: Alignment.topRight,
                  radius: 2,
                  stops: [0.2,0.6]
              )
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 50.0,
                sigmaY: 50.0
            ),
            child: childWidget
          ),
        ),
      ],
    );
  }
}
