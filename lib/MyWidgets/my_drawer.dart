import 'package:eshoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/Models/address.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/Screens/UserHomeScreens/my_orders.dart';
import 'package:eshoppie/Screens/UserHomeScreens/search_page.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_cart.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_update_address.dart';
import 'package:eshoppie/Screens/UserLoginScreens/login.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ionicons/ionicons.dart';

class MyDrawer extends StatelessWidget {
  final UserHomeCubit parentCubit;
  const MyDrawer({Key? key, required this.parentCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: K_whiteColor,
      height: deviceHeight,
      width: deviceWidth! * 0.7,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.all(10.0),
              child: Row(
                children: [
                  K_logoImage,
                  K_hSpace20,
                  MyText(text: 'eShoppie', size: K_fontSizeL)
                ],
              ),
            ),
            K_vSpace20,
            const DrawerItem(
              iconData: CupertinoIcons.cube_box_fill,
              itemText: 'My orders',
              page: MyOrders(isNavFromDrawer: true),
            ),
            const DrawerItem(
              iconData: CupertinoIcons.location_solid,
              itemText: 'Change address',
              page: UpdateUserAddress(),
            ),
            DrawerItem(
              iconData: CupertinoIcons.search_circle_fill,
              itemText: 'Search products',
              page: SearchPage(),
            ),
            SignOutItem(
              parentCubit: parentCubit,
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsetsDirectional.all(10.0),
              child: MyText(
                text: 'eShoppie v1.0.0',
                size: 12.0,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final iconData;
  final itemText;
  final page;
  const DrawerItem({
    Key? key,
    required this.iconData,
    required this.itemText,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, page);
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.all(10.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: K_blackColor,
              size: 30.0,
            ),
            K_hSpace20,
            MyText(text: itemText, size: K_fontSizeM + 2)
          ],
        ),
      ),
    );
  }
}

class SignOutItem extends StatelessWidget {
  final UserHomeCubit parentCubit;
  const SignOutItem({Key? key, required this.parentCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
        );
        await parentCubit.signUserOut();
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.all(10.0),
        child: Row(
          children: [
            const Icon(
              Ionicons.log_out,
              color: K_blackColor,
              size: 30.0,
            ),
            K_hSpace20,
            MyText(text: 'Sign out', size: K_fontSizeM + 2)
          ],
        ),
      ),
    );
  }
}
