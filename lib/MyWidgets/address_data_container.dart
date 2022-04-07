import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_cubit.dart';
import 'package:eshoppie/AppCubits/UserConfirmationOrderCubit/user_confirmation_states.dart';
import 'package:eshoppie/MyWidgets/modal_bottom_sheet.dart';
import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/my_text_field.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDataContainer extends StatelessWidget {
  AddressDataContainer(
      {Key? key,
      required this.cubit,
      required this.city,
      required this.region,
      required this.street})
      : super(key: key);
  final UserConfirmationCubit cubit;
  String city;
  String region;
  String street;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(K_radius + 5),
        topRight: Radius.circular(K_radius + 5),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DashContainer(),
                  K_vSpace20,
                  MyText(
                    text: 'Delivery address',
                    fontWeight: FontWeight.normal,
                    size: K_fontSizeL + 6,
                  ),
                  K_vSpace20,
                  MyTextField(
                    borderColor: K_blackColor,
                    maxlength: 15,
                    labelText: 'Government',
                    labelTextColor: Colors.black38,
                    validatorText: "Field can't be empty !",
                    textController: cubit.governmentController,
                  ),
                  K_vSpace20,
                  MyTextField(
                    borderColor: K_blackColor,
                    maxlength: 20,
                    labelText: 'Region',
                    labelTextColor: Colors.black38,
                    validatorText: "Field can't be empty !",
                    textController: cubit.regionController,
                  ),
                  K_vSpace20,
                  MyTextField(
                    borderColor: K_blackColor,
                    maxlength: 20,
                    labelText: 'Street',
                    labelTextColor: Colors.black38,
                    validatorText: "Field can't be empty !",
                    textController: cubit.streetController,
                  ),
                  K_vSpace10,
                  BlocProvider(
                      //We create another bloc here to update the state of the picking location button
                      create: (context) => UserConfirmationCubit(),
                      child: BlocConsumer<UserConfirmationCubit,
                          UserConfirmationStates>(
                        listener: (context, state) {
                          if (state is ErrorGettingAddressState) {
                            showToastMessage(
                                "Can't pick your location, Try again !",
                                color: Colors.redAccent,
                                textColor: K_whiteColor);
                          } else if (state is SetGotAddressState) {
                            showToastMessage(
                              "Location set successfully !",
                              color: K_blackColor,
                              textColor: K_goldColor,
                            );
                          }
                        },
                        builder: (context, state) {
                          return ConditionalBuilder(
                            condition: state is SetGettingLocationState,
                            builder: (context) => K_progressIndicator,
                            fallback: (context) => MyButton(
                              onPressed: () async {
                                formKey.currentState!.reset();
                                UserConfirmationCubit.get(context)
                                    .setStateToGettingLocationState();
                                try {
                                  await cubit.getLocationByGeo();
                                  UserConfirmationCubit.get(context)
                                      .setStateToGotAddressState();
                                } catch (e) {
                                  UserConfirmationCubit.get(context)
                                      .setStateToErrorAddressState();
                                }
                              },
                              fillColor: K_blackColor,
                              textColor: K_goldColor,
                              text: 'Pick my location',
                              textSize: K_fontSizeL - 3,
                              buttonWidth: double.infinity,
                            ),
                          );
                        },
                      )),
                  K_vSpace20,
                  MyButton(
                    onPressed: () {
                      //Validate the text fields
                      if (formKey.currentState!.validate()) {
                        cubit.setNewAddressFromTextFields();
                        navigateBack(context);
                      }
                    },
                    fillColor: K_blackColor,
                    text: 'Confirm',
                    textSize: K_fontSizeL - 3,
                    buttonWidth: double.infinity,
                  ),
                  K_vSpace20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
