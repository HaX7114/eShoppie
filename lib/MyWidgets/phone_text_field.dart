import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({Key? key}) : super(key: key);

  static bool checkPhoneNumberIsTrue =
      false; //used in form field to make sure that this number is valid
  static String? getPhoneNumberValue; //used in form field to get the value
  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      validator: (value) {
        if (value == null) {
          return 'Phone number can not be empty!';
        } else if (!value.validateLength(type: PhoneNumberType.mobile)) {
          checkPhoneNumberIsTrue = false;
          return 'Invalid phone number!';
        } else {
          checkPhoneNumberIsTrue = true;
        }
      },
      onSaved: (value) {
        getPhoneNumberValue = value!.getFormattedNsn();
      },
      selectorNavigator: ModalBottomSheetNavigator(height: deviceHeight! * 0.7),
      defaultCountry: 'EG',
      style: GoogleFonts.poppins(
        color: K_blackColor,
        fontSize: 13.0,
      ),
      decoration: InputDecoration(
        errorStyle: GoogleFonts.poppins(
          fontSize: 13.0,
        ),
        labelText: 'Phone',
        labelStyle: GoogleFonts.poppins(
          color: K_blackColor,
          fontSize: 13.0,
        ),
        prefixIcon: const Icon(
          CupertinoIcons.phone,
          color: K_blackColor,
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(K_radius),
            borderSide: const BorderSide(
              color: K_blackColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(K_radius),
            borderSide: const BorderSide(
              color: K_blackColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(K_radius),
            borderSide: const BorderSide(
              color: K_blackColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(K_radius),
            borderSide: const BorderSide(
              color: K_blackColor,
            )),
      ),
    );
  }
}
