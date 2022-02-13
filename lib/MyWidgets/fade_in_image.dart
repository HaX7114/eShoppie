import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFadeInImage extends StatelessWidget {
  final String imageURL;
  BoxFit? imageFit;
  MyFadeInImage({Key? key,required this.imageURL,this.imageFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder: const AssetImage('images/white.jpg'),
        image: NetworkImage(imageURL),
        fit: imageFit?? BoxFit.cover,
        width: 100,
        fadeInDuration: const Duration(milliseconds: 200),
        fadeInCurve: Curves.easeInCubic,
        imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.exclamationmark_triangle,color: Colors.orange,),
                K_vSpace10,
                MyText(
                  text: "Couldn't\nload product image",
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  size: K_fontSizeM-2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
    );
  }
}
