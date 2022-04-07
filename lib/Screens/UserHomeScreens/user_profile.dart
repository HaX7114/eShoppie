import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eshoppie/MyWidgets/fade_in_image.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/no_connection.dart';
import 'package:eshoppie/MyWidgets/text_contatiner.dart';
import 'package:eshoppie/Screens/UserLoginScreens/login.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Content();
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserHomeCubit()..getUserData(),
        child: BlocConsumer<UserHomeCubit, UserHomeStates>(
          listener: (context, state) {
            if (state is ErrorSigningOutState) {
              EasyLoading.dismiss();
              showToastMessage('Could not signed you out ! ,Try again',
                  color: K_blackColor, textColor: Colors.redAccent);
            }
            if (state is SignedOutState) {
              EasyLoading.dismiss();
              navigateToWithReplace(context, Login(),
                  transition: PageTransitionType.leftToRight);
            }
          },
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () => onPoping(),
              child: ConditionalBuilder(
                condition: currentUserData != null || state is GotUserDataState,
                fallback: (context) => ConditionalBuilder(
                    condition: state is! ErrorUserDataState,
                    fallback: (context) => const NoConnectionState(),
                    builder: (context) => K_progressIndicator),
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElasticIn(
                        duration: const Duration(milliseconds: 2000),
                        child: Center(
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundColor: Colors.pink[100],
                            child: CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Colors.pink[300],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: MyFadeInImage(
                                  imageURL: currentUserData!.image,
                                  imageFit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      K_vSpace20,
                      K_vSpace20,
                      FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          from: 30.0,
                          child: MyText(
                              text: 'Account info', size: K_fontSizeL + 7)),
                      K_vSpace20,
                      FadeInDown(
                        from: 60.0,
                        duration: const Duration(milliseconds: 600),
                        child: TextContainer(
                            text: currentUserData!.email,
                            color1: Colors.orange[100],
                            color2: Colors.orange[300],
                            icon: CupertinoIcons.mail),
                      ),
                      FadeInDown(
                        from: 60.0,
                        duration: const Duration(milliseconds: 700),
                        child: TextContainer(
                            text: currentUserData!.name,
                            color1: Colors.pink[100],
                            color2: Colors.pink[300],
                            icon: CupertinoIcons.person),
                      ),
                      FadeInDown(
                        from: 60.0,
                        duration: const Duration(milliseconds: 800),
                        child: TextContainer(
                            text: currentUserData!.phoneNumber,
                            color1: Colors.purple[100],
                            color2: Colors.purple[300],
                            icon: CupertinoIcons.phone),
                      ),
                      Expanded(child: Container()),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          width: deviceWidth,
                          child: RawMaterialButton(
                            onPressed: () async {
                              EasyLoading.show(
                                  maskType: EasyLoadingMaskType.black);
                              await UserHomeCubit.get(context).signUserOut();
                            },
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(K_radius)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: MyText(
                                size: K_fontSizeM,
                                text: 'Sign out',
                                color: Colors.purple[300],
                              ),
                            ),
                            fillColor: Colors.purple[100],
                          ),
                        ),
                      ),
                      K_vSpace20,
                      K_vSpace20,
                      K_vSpace20,
                      K_vSpace20,
                      K_vSpace20,
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
