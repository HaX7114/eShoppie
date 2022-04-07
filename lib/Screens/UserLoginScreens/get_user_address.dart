import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_cubit.dart';
import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_states.dart';
import 'package:eshoppie/MyWidgets/address_container.dart';
import 'package:eshoppie/MyWidgets/address_data_container.dart';
import 'package:eshoppie/MyWidgets/modal_bottom_sheet.dart';
import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/snack_bar.dart';
import 'package:eshoppie/Screens/UserLoginScreens/confirm_and_go_home.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class GetUserAddress extends StatelessWidget {
  const GetUserAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserConfirmationCubit(),
      child: BlocConsumer<UserConfirmationCubit, UserConfirmationStates>(
        listener: (context, state) {
          if (state is ErrorSavingAddressState) {
            showToastMessage('Check internet connection and try again !',
                color: Colors.red, textColor: K_whiteColor);
          }
          if (state is SavedAddressState) {
            navigateToWithReplace(
              context,
              const ConfirmAndGoHome(),
            );
          }
        },
        builder: (context, state) {
          UserConfirmationCubit userConfirmationCubit =
              UserConfirmationCubit.get(context);
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container()),
                MyText(
                  text: 'Welcome to eShoppie',
                  size: K_fontSizeL + 4,
                ),
                MyText(
                  text: 'Setting your address',
                  fontWeight: FontWeight.normal,
                  size: K_fontSizeL,
                ),
                Expanded(child: Container()),
                Lottie.asset('lotties/earth.json'),
                K_vSpace20,
                MyText(
                  text:
                      'Setting your delivery address will help us Reaching & Delivering orders to you.',
                  size: K_fontSizeL - 2,
                ),
                K_vSpace20,
                MyText(
                  text: 'Your Delivery Address',
                  size: K_fontSizeL,
                  fontWeight: FontWeight.normal,
                ),
                AddressContainer(
                  cubit: userConfirmationCubit,
                  city: userConfirmationCubit.address.city!,
                  region: userConfirmationCubit.address.region!,
                  street: userConfirmationCubit.address.details!,
                  showAdddressButton: makeAddressEditable(state),
                ),
                K_vSpace20,
                ConditionalBuilder(
                  condition: state is SetGotAddressState ||
                      state is SavingAddressState,
                  builder: (context) => ConditionalBuilder(
                    condition: state is SavingAddressState &&
                        userConfirmationCubit.isSavingNow,
                    fallback: (context) => MyButton(
                      onPressed: () async {
                        await userConfirmationCubit.saveAddressOfUser();
                      },
                      fillColor: K_blackColor,
                      text: 'Confirm address',
                      textColor: K_goldColor,
                      textSize: K_fontSizeL - 3,
                      buttonWidth: double.infinity,
                    ),
                    builder: (context) => K_progressIndicator,
                  ),
                  fallback: (context) => MyButton(
                    onPressed: () {
                      ShowModalSheet(
                        AddressDataContainer(
                          city: userConfirmationCubit.address.city!,
                          cubit: userConfirmationCubit,
                          region: userConfirmationCubit.address.region!,
                          street: userConfirmationCubit.address.details!,
                        ),
                        context,
                      );
                    },
                    fillColor: K_blackColor,
                    text: 'Set address',
                    textColor: K_goldColor,
                    textSize: K_fontSizeL - 3,
                    buttonWidth: double.infinity,
                  ),
                ),
                K_vSpace20
              ],
            ),
          ));
        },
      ),
    );
  }

  bool makeAddressEditable(dynamic addressState) {
    if (addressState is SetGotAddressState) {
      return true;
    } else {
      return false;
    }
  }
}
