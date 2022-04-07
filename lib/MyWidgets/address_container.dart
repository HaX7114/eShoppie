import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_cubit.dart';
import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_states.dart';
import 'package:eshoppie/MyWidgets/address_data_container.dart';
import 'package:eshoppie/MyWidgets/icon_inside_container.dart';
import 'package:eshoppie/MyWidgets/modal_bottom_sheet.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_cart.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressContainer extends StatelessWidget {
  AddressContainer(
      {Key? key,
      required this.cubit,
      required this.city,
      required this.region,
      this.showAdddressButton = false, //Default
      required this.street})
      : super(key: key);
  final UserConfirmationCubit cubit;
  String city;
  bool showAdddressButton;
  String region;
  String street;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const IconInsideContainer(iconData: CupertinoIcons.location),
              K_hSpace20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: street,
                    size: K_fontSizeM,
                  ),
                  MyText(
                    text: region + ', ' + city,
                    size: K_fontSizeM,
                    fontWeight: FontWeight.normal,
                    color: Colors.black38,
                  ),
                ],
              ),
            ],
          ),
          ShowAddressButton(
              cubit: cubit, showAdddressButton: showAdddressButton)
        ],
      ),
    );
  }
}

class ShowAddressButton extends StatelessWidget {
  const ShowAddressButton(
      {Key? key, required this.cubit, required this.showAdddressButton})
      : super(key: key);
  final bool showAdddressButton;
  final UserConfirmationCubit cubit;
  @override
  Widget build(BuildContext context) {
    if (showAdddressButton) {
      return IconButton(
        onPressed: () {
          ShowModalSheet(
            AddressDataContainer(
              city: cubit.address.city!,
              cubit: cubit,
              region: cubit.address.region!,
              street: cubit.address.details!,
            ),
            context,
          );
        },
        icon: const Icon(
          Icons.edit_outlined,
        ),
      );
    } else {
      return const Center();
    }
  }
}
