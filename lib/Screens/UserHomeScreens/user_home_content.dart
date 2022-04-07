import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eshoppie/MyWidgets/categories_horizontal_list.dart';
import 'package:eshoppie/MyWidgets/list_view_with_separator.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/no_connection.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BuildContext? homeContentContext; //Use it any where

class UserHomeContent extends StatelessWidget {
  const UserHomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    homeContentContext = context;

    return BlocProvider(
      create: (context) => UserHomeCubit()
        ..getAllProducts()
        ..getAllCategories(),
      child: BlocConsumer<UserHomeCubit, UserHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UserHomeCubit userHomeCubit = UserHomeCubit.get(context);
          return ConditionalBuilder(
            condition: state is GotProductsLoadingState,
            builder: (context) => K_progressIndicator,
            fallback: (context) => ConditionalBuilder(
                condition: state is GotProductsState,
                builder: (context) => FadeInLeft(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 130.0,
                                bottom: 5.0,
                                left: 15.0,
                                right: 15.0),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: ListViewWithSeparator(
                                list: userHomeCubit.products,
                                userHomeCubit: userHomeCubit,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 120.0,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ],
                              color: K_whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, bottom: 10.0),
                                  child: MyText(
                                      text: 'eShoppie Collection',
                                      size: K_fontSizeL + 7),
                                ),
                                K_vSpace10,
                                CategoriesHorizontalList(
                                  cateList: userHomeCubit.categories,
                                  userHomeCubit: userHomeCubit,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                fallback: state is GotProductsErrorState ||
                        state is GotCategoriesErrorState
                    ? (context) => const NoConnectionState()
                    : (context) => K_progressIndicator),
          );
        },
      ),
    );
  }
}
