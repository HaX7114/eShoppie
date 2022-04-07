import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/material.dart';

dynamic ShowModalSheet(dynamic widget, dynamic context, {dynamic height}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(K_radius + 5),
          topRight: Radius.circular(K_radius + 5),
        ),
        color: K_whiteColor,
      ),
      height: height ?? deviceHeight! * 0.75,
      child: widget,
    ),
  );
}

class DashContainer extends StatelessWidget {
  const DashContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(K_radius),
          child: Container(
            color: Colors.black12,
            height: 5.0,
            width: 40.0,
          ),
        ),
      ),
    );
  }
}
