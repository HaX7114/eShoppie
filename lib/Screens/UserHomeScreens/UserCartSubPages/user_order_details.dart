import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserOrderDetailsCubit/user_order_details_cubit.dart';
import 'package:eshoppie/AppCubits/UserOrderDetailsCubit/user_order_details_states.dart';
import 'package:eshoppie/MyWidgets/modal_bottom_sheet.dart';
import 'package:eshoppie/MyWidgets/my_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/no_connection.dart';
import 'package:eshoppie/MyWidgets/order_details_product_container.dart';
import 'package:eshoppie/MyWidgets/snack_bar.dart';
import 'package:eshoppie/Screens/UserHomeScreens/UserCartSubPages/order_set_success.dart';
import 'package:eshoppie/Screens/UserHomeScreens/user_cart.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserOrderDetails extends StatelessWidget {
  const UserOrderDetails({Key? key, required this.controller})
      : super(key: key);

  final PageController controller;

  Widget determinePaymentButton(
    bool isCashPayment,
    UserOrderDetailsCubit cubit,
  ) {
    if (isCashPayment) {
      return Expanded(
        child: MyButton(
          onPressed: () async {
            //place the order
            EasyLoading.show(maskType: EasyLoadingMaskType.black);
            await cubit.setOrder(cashPayment);
          },
          fillColor: K_blackColor,
          text: 'Place order',
          textColor: K_goldColor,
          buttonWidth: double.infinity,
        ),
      );
    } else {
      return Expanded(
        child: MyButton(
          onPressed: () {},
          fillColor: K_blackColor,
          text: 'Add Card Data',
          buttonWidth: double.infinity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (EasyLoading.isShow) {
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: BlocProvider(
        create: (context) => UserOrderDetailsCubit()..getCartsProducts(),
        child: BlocConsumer<UserOrderDetailsCubit, UserOrderDetailsStates>(
          listener: (context, state) {
            if (state is OrderSetSuccessState) {
              navigateBack(context);
              navigateToWithReplace(context, const OrderSetSuccess());
            } else if (state is OrderNotSetFailState) {
              EasyLoading.showError('An error occurred please try again!',
                  maskType: EasyLoadingMaskType.black);
            }
            EasyLoading.dismiss();
          },
          builder: (context, state) {
            UserOrderDetailsCubit userOrderDetailsCubit =
                UserOrderDetailsCubit.get(context);
            return ConditionalBuilder(
              condition: state is CartProductsLoadingState,
              builder: (context) => K_progressIndicator,
              fallback: (context) => ConditionalBuilder(
                condition: state is CartErrorState,
                builder: (context) => const NoConnectionState(),
                fallback: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const DashContainer(),
                          K_vSpace20,
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.animateToPage(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                },
                                icon: const Icon(
                                  CupertinoIcons.back,
                                  size: 28.0,
                                  color: K_blackColor,
                                ),
                              ),
                              Center(
                                child: MyText(
                                  text: 'Order details',
                                  fontWeight: FontWeight.normal,
                                  size: K_fontSizeL + 6,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120.0, bottom: 85),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return OrderDetailsProductContainer(
                                    cartID: userOrderDetailsCubit
                                        .userCartProducts[index].cartID,
                                    imageURL: userOrderDetailsCubit
                                        .userCartProducts[index].product!.image,
                                    productName: userOrderDetailsCubit
                                        .userCartProducts[index].product!.name,
                                    productPrice: userOrderDetailsCubit
                                        .userCartProducts[index].product!.price,
                                    productQuantity: userOrderDetailsCubit
                                        .userCartProducts[index].quantity,
                                    parentCubit: userOrderDetailsCubit,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    K_vSpace20,
                                itemCount: userOrderDetailsCubit
                                    .userCartProducts.length,
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Expanded(child: Container()),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Total',
                                    size: K_fontSizeL,
                                  ),
                                  MyText(
                                    text: userOrderDetailsCubit.total
                                            .toStringAsFixed(2) +
                                        " EGP",
                                    size: K_fontSizeM - 2,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              K_hSpace20,
                              K_hSpace20,
                              determinePaymentButton(
                                isCashPayment,
                                userOrderDetailsCubit,
                              ),
                            ],
                          ),
                          K_vSpace10,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
