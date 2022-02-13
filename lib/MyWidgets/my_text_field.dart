import 'package:eShoppie/constants.dart';
import 'package:eShoppie/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_strength/password_strength.dart';

class MyTextField extends StatelessWidget {
  final hintText;
  final hintTextColor;
  final isEmailField;
  final isPasswordField;
  final labelText;
  final labelTextColor;
  final obscureText;
  final prifixIcon;
  final borderColor;
  final maxlength;
  final borderRadius;
  final validatorText;
  ValueChanged<String>? onChange;
  final TextEditingController textController;

  MyTextField({
    Key? key,
    this.hintText,
    this.hintTextColor,
    this.labelText,
    this.labelTextColor,
    this.maxlength,
    this.isEmailField = false, //default,
    this.isPasswordField = false, //default,
    this.obscureText,
    required this.borderColor,
    required this.validatorText,
    this.prifixIcon,
    required this.textController,
    this.borderRadius,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText ?? false,
      maxLength: maxlength,
      validator: (value) {
        if (isEmailField) {
          if (!EmailValidator.validate(value!) && value.isNotEmpty) {
            return 'Email is invalid!';
          } else if (value == null || value.isEmpty) {
            return validatorText;
          }
        } else if (isPasswordField) {
          if (estimatePasswordStrength(value!) <= 0.3 && value.isNotEmpty) {
            return 'Password is too weak!';
          } else if (value == null || value.isEmpty) {
            return validatorText;
          }
        } else {
          if (value == null || value.isEmpty) {
            return validatorText;
          }
        }
      },
      onChanged: onChange,
      style: GoogleFonts.poppins(
        color: labelTextColor ?? K_blackColor,
        fontSize: 13.0,
      ),
      decoration: InputDecoration(
        prefixIcon: prifixIcon != null
            ? Icon(
                prifixIcon,
                color: K_blackColor,
              )
            : null,
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(
          color: labelTextColor ?? K_blackColor,
          fontSize: 13.0,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: hintTextColor ?? K_greyColor,
          fontSize: 13.0,
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: 13.0,
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? K_radius),
            borderSide: BorderSide(
              color: borderColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? K_radius),
            borderSide: BorderSide(
              color: borderColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? K_radius),
            borderSide: BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? K_radius),
            borderSide: BorderSide(
              color: borderColor,
            )),
      ),
    );
  }
}
