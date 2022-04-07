import 'package:animate_do/animate_do.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoCartsWidget extends StatelessWidget {
  const NoCartsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: const Duration(seconds: 2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.cart,
              size: 80.0,
              color: Colors.grey,
            ),
            K_vSpace20,
            K_vSpace20,
            MyText(
              text: "Your cart is empty !",
              size: K_fontSizeL,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}
