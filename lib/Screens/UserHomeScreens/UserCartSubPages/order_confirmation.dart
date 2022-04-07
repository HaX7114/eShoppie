import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_cubit.dart';
import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_states.dart';
import 'package:eshoppie/MyWidgets/address_container.dart';
import 'package:eshoppie/MyWidgets/modal_bottom_sheet.dart';
import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/payment_method.dart';
import 'package:eshoppie/MyWidgets/snack_bar.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_cart.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserConfirmationCubit()
        ..setUserAddressDefaultData(), //We call here to get the saved data when initialized
      child: BlocConsumer<UserConfirmationCubit, UserConfirmationStates>(
        listener: (context, state) {
          if (state is ErrorSavingUpdateAddressState) {
            showToastMessage('Check internet connection and try again !',
                color: Colors.red, textColor: K_whiteColor);
          }

          if (state is SavedUpdatedAddressState) {
            controller.animateToPage(1,
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn);
          }
        },
        builder: (context, state) {
          UserConfirmationCubit userConfirmationCubit =
              UserConfirmationCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashContainer(),
                K_vSpace20,
                MyText(
                  text: 'Order Confirmation',
                  fontWeight: FontWeight.normal,
                  size: K_fontSizeL + 6,
                ),
                K_vSpace20,
                GestureDetector(
                  onTap: () {
                    userConfirmationCubit.changePaymentContainerColor();
                    //We update the value of isCash to decide whether to (show Add Card Data or Place order) in user order details page
                    isCashPayment = userConfirmationCubit.isCashPayment;
                  },
                  child: PaymentContainer(
                    text: 'Pay cash on Delivery',
                    isSelected: isCashPayment,
                    iconData: CupertinoIcons.money_pound_circle_fill,
                    iconSize: 50.0,
                  ),
                ),
                K_vSpace10,
                //Horizontal line ( -- or -- )
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black26,
                        height: 1.0,
                      ),
                    ),
                    MyText(text: '  or  ', size: K_fontSizeM),
                    Expanded(
                      child: Container(
                        color: Colors.black26,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                K_vSpace10,
                GestureDetector(
                  onTap: () {
                    userConfirmationCubit.changePaymentContainerColor();
                    //We update the value of isCash to decide whether to (show Add Card Data or Place order) in user order details page
                    isCashPayment = userConfirmationCubit.isCashPayment;
                  },
                  child: PaymentContainer(
                    text: 'Pay with card',
                    isSelected: !isCashPayment,
                    iconData: CupertinoIcons.creditcard_fill,
                    iconSize: 45.0,
                  ),
                ),
                K_vSpace20,
                MyText(
                  text: 'Delivery address',
                  size: K_fontSizeL,
                  fontWeight: FontWeight.normal,
                ),
                AddressContainer(
                    showAdddressButton: true,
                    cubit: userConfirmationCubit,
                    city: userConfirmationCubit.address.city!,
                    region: userConfirmationCubit.address.region!,
                    street: userConfirmationCubit.address.details!),
                Expanded(child: Container()),
                ConditionalBuilder(
                  condition: state is! SavingUpdatedAddressState,
                  builder: (context) => MyButton(
                    onPressed: () async {
                      //We get this to check whether the user has edit his location or not | we can get any var not lat only but we check on the lat because it is critical

                      dynamic savedLat =
                          SharedHandler.getSharedPref(SharedHandler.saveLatKey);
                      // userConfirmationCubit.address.latitude  if this changed it will not equal the saveLat and we will know that the location has changed
                      if (userConfirmationCubit.address.latitude == savedLat) {
                        //First case if the location has not changed then we will not update it  and we will go to the next page
                        controller.animateToPage(1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                      } else {
                        //This means that the location has been changed and we must call the update function here
                        await userConfirmationCubit.updateAddressOfUser();

                        //else we will add an if statement on the listner ro show snack bar that inform the user to try again
                      }
                    },
                    fillColor: K_blackColor,
                    text: 'Next',
                    textSize: K_fontSizeL - 3,
                    buttonWidth: double.infinity,
                  ),
                  fallback: (context) => K_progressIndicator,
                ),
                K_vSpace20
              ],
            ),
          );
        },
      ),
    );
  }
}
