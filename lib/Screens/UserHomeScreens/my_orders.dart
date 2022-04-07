import 'dart:collection';

import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/MyOrdersScreenCubit/my_orders_cubit.dart';
import 'package:eshoppie/AppCubits/MyOrdersScreenCubit/my_orders_states.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eshoppie/MyWidgets/categories_horizontal_list.dart';
import 'package:eshoppie/MyWidgets/list_view_with_separator.dart';
import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/no_connection.dart';
import 'package:eshoppie/MyWidgets/no_orders.dart';
import 'package:eshoppie/Screens/UserHomeScreens/MyOrdersSubPage/load_order_details.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_home.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BuildContext? homeContentContext; //Use it any where

class MyOrders extends StatelessWidget {
  final bool isNavFromDrawer;
  const MyOrders({Key? key, required this.isNavFromDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyOrdersCubit()..getAllOrders(),
      child: BlocConsumer<MyOrdersCubit, MyOrdersStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MyOrdersCubit myOrdersCubit = MyOrdersCubit.get(context);
          return WillPopScope(
            onWillPop: () {
              if (isNavFromDrawer) {
                return Future.value(true);
              } else {
                return Future.value(false);
              }
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: K_whiteColor.withOpacity(0.8),
                elevation: 0.0,
                title: MyText(text: 'My orders', size: K_fontSizeL),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      if (isNavFromDrawer) {
                        navigateBack(context);
                      } else {
                        navigateToWithReplace(context, UserHome());
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: K_blackColor,
                      size: 28.0,
                    )),
              ),
              body: ConditionalBuilder(
                condition: state is LoadingOrdersState,
                builder: (context) => K_progressIndicator,
                fallback: (context) => ConditionalBuilder(
                    condition: state is LoadedOrdersState,
                    builder: (context) => FadeInLeft(
                            child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              K_vSpace20,
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: shadow,
                                            color: K_whiteColor,
                                            borderRadius: BorderRadius.circular(
                                                K_radius)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 25.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  MyText(
                                                    text:
                                                        'Order NO: ${myOrdersCubit.orders[index].id}',
                                                    size: K_fontSizeM,
                                                    color: K_blackColor,
                                                  ),
                                                  MyText(
                                                    text:
                                                        '${myOrdersCubit.orders[index].date}',
                                                    size: K_fontSizeM,
                                                    color: K_blackColor,
                                                  ),
                                                ],
                                              ),
                                              K_vSpace10,
                                              MyText(
                                                text: 'Total Amount:  ' +
                                                    myOrdersCubit
                                                        .orders[index].total
                                                        .toStringAsFixed(2) +
                                                    ' EGP',
                                                fontWeight: FontWeight.normal,
                                                size: K_fontSizeM,
                                                color: K_blackColor,
                                              ),
                                              K_vSpace20,
                                              K_vSpace10,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: MyButton(
                                                      text: 'Details',
                                                      borderRadius: K_radius,
                                                      height: 50.0,
                                                      onPressed: () {
                                                        navigateTo(
                                                            context,
                                                            LoadOrderDetails(
                                                                orderID:
                                                                    myOrdersCubit
                                                                        .orders[
                                                                            index]
                                                                        .id));
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    child: MyText(
                                                        textAlign:
                                                            TextAlign.end,
                                                        text:
                                                            '${myOrdersCubit.orders[index].status}',
                                                        size: K_fontSizeM - 2,
                                                        color: myOrdersCubit
                                                                    .orders[
                                                                        index]
                                                                    .status ==
                                                                'New'
                                                            ? Colors.green
                                                            : Colors.red),
                                                  ),
                                                  K_hSpace20,
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 2,
                                    );
                                  },
                                  itemCount: myOrdersCubit.orders.length),
                            ],
                          ),
                        )),
                    fallback: state is ErrorWhileLoadingOrdersState
                        ? (context) => const NoConnectionState()
                        : (context) => const NoOrdersWidget()),
              ),
            ),
          );
        },
      ),
    );
  }
}
