import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eshoppie/MyWidgets/my_drawer.dart';
import 'package:eshoppie/Screens/UserHomeScreens/search_page.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_cart.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_favorites.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_home_content.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_profile.dart';
import 'package:eshoppie/Screens/UserLoginScreens/login.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

class UserHome extends StatelessWidget {
  UserHome({Key? key}) : super(key: key);

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Padding(
        padding: EdgeInsets.all(6.0),
        child: Icon(CupertinoIcons.home),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Favorites',
      icon: Icon(CupertinoIcons.suit_heart),
    ),
    BottomNavigationBarItem(
      label: 'Cart',
      icon: Icon(CupertinoIcons.cart),
    ),
    BottomNavigationBarItem(
      label: 'My Profile',
      icon: Icon(
        CupertinoIcons.person,
      ),
    ),
  ];

  List<Widget> userHomeScreens = const [
    UserHomeContent(),
    UserFavorite(),
    UserCart(),
    UserProfile()
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => UserHomeCubit(),
      child: BlocConsumer<UserHomeCubit, UserHomeStates>(
        listener: (context, state) {
          if (state is ErrorSigningOutState) {
            EasyLoading.dismiss();
            showToastMessage('Could not signed you out ! ,Try again',
                color: K_blackColor, textColor: Colors.redAccent);
          } else if (state is SignedOutState) {
            EasyLoading.dismiss();
            navigateToWithReplace(context, Login(),
                transition: PageTransitionType.leftToRight);
          }
        },
        builder: (context, state) {
          UserHomeCubit userHomeCubit = UserHomeCubit.get(context);
          return WillPopScope(
            onWillPop: () {
              if (EasyLoading.isShow) {
                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            child: Scaffold(
              key: scaffoldKey,
              drawer: MyDrawer(
                parentCubit: userHomeCubit,
              ),
              extendBody: true,
              appBar: AppBar(
                backgroundColor: K_whiteColor.withOpacity(0.8),
                elevation: 0.0,
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SearchPage(),
                            transition: PageTransitionType.fade);
                      },
                      icon: const Icon(
                        CupertinoIcons.search,
                        color: K_blackColor,
                        size: 28.0,
                      )),
                ],
                leading: IconButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Ionicons.menu,
                      color: K_blackColor,
                      size: 28.0,
                    )),
              ),
              body: userHomeScreens[userHomeCubit.currentIndex],
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(K_radius),
                  child: BottomNavigationBar(
                    backgroundColor: K_blackColor,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: userHomeCubit.currentIndex,
                    onTap: (newIndex) {
                      userHomeCubit.changeNavBarIndex(newIndex);
                    },
                    selectedIconTheme: const IconThemeData(
                      color: K_whiteColor,
                    ),
                    unselectedIconTheme: const IconThemeData(
                      color: K_greyColor,
                    ),
                    iconSize: 27.0,
                    items: bottomNavItems,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
