import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eShoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eShoppie/AppCubits/LoginScreenCubit/login_states.dart';
import 'package:eShoppie/MyWidgets/gradient_background.dart';
import 'package:eShoppie/MyWidgets/my_button.dart';
import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/MyWidgets/my_text_field.dart';
import 'package:eShoppie/MyWidgets/snack_bar.dart';
import 'package:eShoppie/Screens/UserHomeScreens/user_home.dart';
import 'package:eShoppie/Screens/UserLoginScreens/sign_up.dart';
import 'package:eShoppie/Shared/functions.dart';
import 'package:eShoppie/Shared/shared_preference.dart';
import 'package:eShoppie/constants.dart';
import 'package:eShoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LoginCubit loginCubit = LoginCubit.get(context);

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
                            Center(
                                child: MyText(
                                    text: 'eShoppie', size: K_fontSizeL)),
                            K_vSpace20,
                            K_vSpace20,
                            MyText(text: 'Login', size: K_fontSizeL + 10),
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
                              obscureText: true,
                              prifixIcon: CupertinoIcons.padlock,
                              textController: passwordTextController,
                            ),
                            K_vSpace20,
                            ConditionalBuilder(
                              condition: state is! AwaitLoginResultState,
                              fallback: (context) => K_progressIndicator,
                              builder: (context) => MyButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await loginCubit.loginUser(
                                        emailTextController.text,
                                        passwordTextController.text);
                                    await goToHomePageOrShowError(
                                        loginCubit.resultOfLogin, context);
                                  }
                                },
                                text: 'Login',
                              ),
                            ),
                            K_vSpace20,
                            MyButton(
                              onPressed: () {
                                navigateToWithReplace(context, SignUp(),
                                    transition: PageTransitionType.leftToRight);
                              },
                              fillColor: Colors.black12,
                              textColor: K_blackColor,
                              text: "Don't have an account? Sign Up",
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
        ));
  }

  goToHomePageOrShowError(int resultOfLogin, context) async {
    if (resultOfLogin == 1) {
      navigateToWithReplace(context, UserHome());
      await SharedHandler.setSharedPref(SharedHandler.saveLoginKey, true);
    } else if (resultOfLogin == 2) {
      showSnackBar(
          context, 'The email or password is incorrect !', Colors.redAccent,
          icon: CupertinoIcons.info_circle_fill, iconColor: K_whiteColor);
    } else {
      showSnackBar(
          context, 'Check your internet connection !', Colors.redAccent,
          icon: CupertinoIcons.info_circle_fill, iconColor: K_whiteColor);
    }
  }
}
