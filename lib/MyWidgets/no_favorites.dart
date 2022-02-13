import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoFavoritesWidget extends StatelessWidget {
  const NoFavoritesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.heart_slash,
            size: 80.0,
            color: Colors.grey,
          ),
          K_vSpace20,
          K_vSpace20,
          MyText(text: "No favorites yet !", size: K_fontSizeL),
        ],
      ),
    );
  }
}
