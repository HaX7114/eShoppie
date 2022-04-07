import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';

enum PaymentMethod { cash, online }

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.iconData,
    required this.iconSize,
  }) : super(key: key);

  final isSelected;
  final iconData;
  final text;
  final iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(K_radius),
        color: isSelected ? K_blackColor : Colors.black12,
      ),
      height: 90.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 25.0),
          child: Row(
            children: [
              Icon(
                iconData,
                size: iconSize,
                color: isSelected ? K_whiteColor : K_blackColor,
              ),
              K_hSpace20,
              MyText(
                text: text,
                size: K_fontSizeM,
                color: isSelected ? K_goldColor : K_blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
