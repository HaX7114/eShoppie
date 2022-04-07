import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eshoppie/MyWidgets/address_container.dart';
import 'package:eshoppie/MyWidgets/list_view_with_separator.dart';
import 'package:eshoppie/MyWidgets/modal_bottom_sheet.dart';
import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/no_cart.dart';
import 'package:eshoppie/MyWidgets/no_connection.dart';
import 'package:eshoppie/MyWidgets/payment_method.dart';
import 'package:eshoppie/Screens/UserHomeScreens/UserCartSubPages/order_confirmation.dart';
import 'package:eshoppie/Screens/UserHomeScreens/UserCartSubPages/user_order_details.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isCashPayment =
    true; //We make this global because we use it in two different pages order confirmation & user order details

class UserCart extends StatelessWidget {
  const UserCart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserHomeCubit()..getCartsProducts(),
      child: BlocConsumer<UserHomeCubit, UserHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UserHomeCubit userHomeCubit = UserHomeCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is GotProductsLoadingState,
              builder: (context) => K_progressIndicator,
              fallback: (context) => ConditionalBuilder(
                condition: state is GotProductsState,
                builder: (context) => Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 100.0,
                                bottom: 15.0,
                                end: 15.0,
                                start: 15.0),
                            child: ListViewWithSeparator(
                              list: userHomeCubit.products,
                              userHomeCubit: userHomeCubit,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ],
                        color: K_whiteColor,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15.0, bottom: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: MyText(
                                    text: 'Your cart', size: K_fontSizeL + 5)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: MyButton(
                                  onPressed: () {
                                    ShowModalSheet(
                                        const ModalSheetContainer(), context);
                                  },
                                  textColor: K_whiteColor,
                                  fillColor: K_blackColor,
                                  text: 'Order now',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                fallback: (context) => state is! NoCartsState
                    ? const NoConnectionState()
                    : const NoCartsWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ModalSheetContainer extends StatelessWidget {
  const ModalSheetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: pageController,
      children: [
        OrderConfirmation(
          controller: pageController,
        ),
        UserOrderDetails(
          controller: pageController,
        )
      ],
    );
  }
}
