import 'package:animate_do/animate_do.dart';
import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoConnectionState extends StatelessWidget {
  const NoConnectionState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: const Duration(seconds: 2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.wifi_slash,
              size: 80.0,
              color: Colors.grey,
            ),
            K_vSpace20,
            K_vSpace20,
            MyText(text: 'No internet connection !', size: K_fontSizeL),
          ],
        ),
      ),
    );
  }
}
