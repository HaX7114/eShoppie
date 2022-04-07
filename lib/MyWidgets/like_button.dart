import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eshoppie/MyWidgets/snack_bar.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_home_content.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LikeButton extends StatelessWidget {
  double? size;
  final isFavoriteProduct;
  final color;
  final productIndex;
  final products;
  LikeButton(
      {Key? key,
      this.size,
      required this.isFavoriteProduct,
      required this.color,
      required this.productIndex,
      required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeCubit(),
      child: BlocConsumer<UserHomeCubit, UserHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UserHomeCubit userHomeCubit = UserHomeCubit.get(context);
          return IconButton(
            onPressed: () async {
              userHomeCubit.isLikedProduct = products[productIndex]
                  .inFavorites; //Override the value of the isLikedProduct
              userHomeCubit.changeLikeButtonState(userHomeCubit
                  .isLikedProduct); //We use this to change the current value of heart icon and save the new value on the server

              products[productIndex].inFavorites = userHomeCubit
                  .isLikedProduct; //We use this to edit the current value of inFavourite to be updated in the ui

              userHomeCubit.addToFavorites(
                  products[productIndex].id); //Add new value to the server

              if (products[productIndex].inFavorites) {
                showToastMessage('Product added to your favorites');
              } else {
                showToastMessage('Product removed from your favorites');
              }
            },
            icon: Icon(
              products[productIndex].inFavorites
                  ? CupertinoIcons.suit_heart_fill
                  : CupertinoIcons.suit_heart,
              color: color,
              size: size ?? 25.0,
            ),
          );
        },
      ),
    );
  }
}
