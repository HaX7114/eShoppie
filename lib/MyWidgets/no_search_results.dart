import 'package:animate_do/animate_do.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoResultsState extends StatelessWidget {
  const NoResultsState({Key? key, required this.searchTextController})
      : super(key: key);

  final TextEditingController searchTextController;
  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: const Duration(seconds: 2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.doc_text_search,
              size: 80.0,
              color: Colors.grey,
            ),
            K_vSpace20,
            K_vSpace20,
            MyText(text: 'Sorry !', size: K_fontSizeL),
            K_vSpace10,
            MyText(
              textAlign: TextAlign.center,
              text:
                  'There is no results for this "${searchTextController.text}" key word !',
              size: K_fontSizeM,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}
