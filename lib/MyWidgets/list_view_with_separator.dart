import 'package:animate_do/animate_do.dart';
import 'package:eshoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/Models/product.dart';
import 'package:eshoppie/MyWidgets/cart_button.dart';
import 'package:eshoppie/MyWidgets/product_container.dart';
import 'package:eshoppie/Screens/UserHomeScreens/UserHomeContentSubScreens/product_details_screen.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/api_handler.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListViewWithSeparator extends StatelessWidget {
  final List<Product> list;
  final dynamic userHomeCubit;
  const ListViewWithSeparator(
      {Key? key, required this.list, required this.userHomeCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      separatorBuilder: (context, index) {
        return K_vSpace20;
      },
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              navigateTo(
                  context,
                  ProductDetails(
                    product: list[index],
                    productIndex: index,
                    products: list,
                  ),
                  transition: PageTransitionType.fade);
            },
            child: FadeInLeft(
                child: ProductContainer(
              productIndex: index,
              product: list[index],
              products: list,
            )));
      },
    );
  }
}
