import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final text;
  final size;
  final color;
  final textAlign;
  final fontWeight;
  int? maxLinesNumber;
  bool showEllipsis;

  MyText(
      {Key? key,
      this.maxLinesNumber,
      required this.text,
      required this.size,
      this.color,
      this.textAlign,
      this.fontWeight,
      this.showEllipsis = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLinesNumber,
      overflow: showEllipsis ? TextOverflow.ellipsis : null,
      style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
        color: color ?? K_blackColor,
      ),
    );
  }
}
