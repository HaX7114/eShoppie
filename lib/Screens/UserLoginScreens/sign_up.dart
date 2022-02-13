import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eShoppie/AppCubits/SignupCubit/signup_cubit.dart';
import 'package:eShoppie/AppCubits/SignupCubit/signup_states.dart';
import 'package:eShoppie/MyWidgets/gradient_background.dart';
import 'package:eShoppie/MyWidgets/my_button.dart';
import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/MyWidgets/my_text_field.dart';
import 'package:eShoppie/MyWidgets/phone_text_field.dart';
import 'package:eShoppie/MyWidgets/snack_bar.dart';
import 'package:eShoppie/Screens/UserLoginScreens/login.dart';
import 'package:eShoppie/Shared/functions.dart';
import 'package:eShoppie/constants.dart';
import 'package:eShoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignupStates>(
          listener: (context, state){

          },
          builder: (context, state){
            SignUpCubit signUpCubit = SignUpCubit.get(context);
            return Scaffold(
              body: Form(
                  key: formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(K_mainPadding),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              K_vSpace20,
                              K_vSpace20,
                              const Center(
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: K_blackColor,
                                  size: 90,
                                ),
                              ),
                              Center(child: MyText(text: 'eShoppie', size: K_fontSizeL)),
                              K_vSpace20,
                              MyText(text: 'Welcome guest !', size: K_fontSizeL,fontWeight: FontWeight.w300,),
                              MyText(text: 'Create account', size: K_fontSizeL+10),
                              K_vSpace20,
                              MyTextField(
                                borderColor: K_blackColor,
                                validatorText: 'Username field can not be empty!',
                                labelText: 'Username',
                                prifixIcon: CupertinoIcons.person,
                                textController: nameTextController,
                              ),
                              K_vSpace20,
                              MyTextField(
                                borderColor: K_blackColor,
                                validatorText: 'Email field can not be empty!',
                                labelText: 'Email',
                                isEmailField: true,
                                prifixIcon: CupertinoIcons.mail,
                                textController: emailTextController,
                              ),
                              K_vSpace20,
                              MyTextField(
                                borderColor: K_blackColor,
                                validatorText: 'Password field can not be empty!',
                                labelText: 'Password',
                                isPasswordField: true,
                                obscureText: true,
                                prifixIcon: CupertinoIcons.padlock,
                                textController: passwordTextController,
                              ),
                              K_vSpace20,
                              const PhoneTextField(),
                              K_vSpace20,
                              ConditionalBuilder(
                                condition: state is! AwaitSignupResultState,
                                fallback: (context) => K_progressIndicator,
                                builder: (context) => MyButton(
                                  onPressed: () async {
                                    if(formKey.currentState!.validate())
                                    {
                                      formKey.currentState!.save();
                                      await signUpCubit.signUpUser(
                                        nameTextController.text,
                                        emailTextController.text,
                                        passwordTextController.text,
                                        PhoneTextField.getPhoneNumberValue,
                                      );
                                      goToHomePageOrShowError(signUpCubit.resultOfSignUp, context, signUpCubit.message);
                                    }
                                  },
                                  text: 'Sign Up',
                                ),
                              ),
                              K_vSpace20,
                              MyButton(
                                onPressed: (){
                                  navigateToWithReplace(context, Login());
                                },
                                fillColor: Colors.black12,
                                textColor: K_blackColor,
                                text: 'Have an account? Login',
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            );
          },
      )
    );
  }

  goToHomePageOrShowError(int resultOfSignUp,context,message){
    if(resultOfSignUp == 1){
      navigateToWithReplace(context, Login());
    }else if(resultOfSignUp == 2){
      showSnackBar(context, message, Colors.redAccent,icon: CupertinoIcons.info_circle_fill,iconColor: K_whiteColor);
    }else{
      showSnackBar(context, 'Check your internet connection !', Colors.redAccent,icon: CupertinoIcons.info_circle_fill,iconColor: K_whiteColor);
    }
  }
}
