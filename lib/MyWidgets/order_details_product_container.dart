import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/UserOrderDetailsCubit/user_order_details_cubit.dart';
import 'package:eshoppie/AppCubits/UserOrderDetailsCubit/user_order_details_states.dart';
import 'package:eshoppie/MyWidgets/fade_in_image.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/snack_bar.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsProductContainer extends StatelessWidget {
  final imageURL;
  final productPrice;
  int qty;
  final cartID;
  final productName;
  final productQuantity;
  final dynamic parentCubit;
  OrderDetailsProductContainer(
      {Key? key,
      required this.imageURL,
      this.cartID,
      required this.productName,
      required this.productPrice, //This will hold the value of the price * qty
      required this.productQuantity,
      this.qty = 0,
      required this.parentCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserOrderDetailsCubit(),
        child: BlocConsumer<UserOrderDetailsCubit, UserOrderDetailsStates>(
          listener: (context, state) {
            if (state is ErrorWhileChangingTheAmount) {
              showToastMessage('Can not update the quantity, Try again!',
                  textColor: Colors.redAccent, color: K_blackColor);
            }
          },
          builder: (context, state) {
            UserOrderDetailsCubit productCubit =
                UserOrderDetailsCubit.get(context);
            if (productCubit.productQuantity == 0) {
              productCubit.setProductQuantity(productQuantity);
              productCubit.setProductPrice(productPrice);
              productCubit.setProductPriceQty(productQuantity * productPrice);
            }
            return Row(
              children: [
                MyFadeInImage(imageURL: imageURL),
                K_hSpace20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: productName,
                        size: K_fontSizeM - 2,
                        maxLinesNumber: 2,
                      ),
                      K_vSpace10,
                      MyText(
                        text: productCubit.productTotalPriceQty
                                .toStringAsFixed(2) +
                            " EGP",
                        size: K_fontSizeM,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                showChangeQtyColumn(cartID, productCubit, state, qty: qty)
              ],
            );
          },
        ));
  }

  showChangeQtyColumn(cartID, productCubit, state, {qty}) {
    if (cartID != 0) {
      return Column(
        children: [
          IconButton(
            onPressed: () async {
              //To control the qty amount
              if (productCubit.productQuantity < 10) {
                await productCubit.increaseAmount(cartID, parentCubit);
              }
            },
            icon: Icon(CupertinoIcons.plus,
                color: productCubit.productQuantity != 10
                    ? K_blackColor
                    : K_blackColor.withOpacity(0.2),
                size: 20.0),
          ),
          K_hSpace10,
          ConditionalBuilder(
            condition: state is LoadingWhileChangingTheAmount,
            builder: (context) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                child: K_progressIndicator,
                height: 20.0,
                width: 20.0,
              ),
            ),
            fallback: (context) => CircleAvatar(
              backgroundColor: K_blackColor,
              child: MyText(
                text: 'x${productCubit.productQuantity}',
                size: K_fontSizeM,
                color: K_whiteColor,
              ),
            ),
          ),
          K_hSpace10,
          IconButton(
            onPressed: () async {
              //To control the qty amount
              if (productCubit.productQuantity > 1) {
                await productCubit.decreaseAmount(cartID, parentCubit);
              }
            },
            icon: Icon(
              CupertinoIcons.minus,
              color: productCubit.productQuantity != 1
                  ? K_blackColor
                  : K_blackColor.withOpacity(0.2),
              size: 20.0,
            ),
          ),
        ],
      );
    } else {
      return CircleAvatar(
        backgroundColor: K_blackColor,
        child: MyText(
          text: 'x$qty',
          size: K_fontSizeM,
          color: K_whiteColor,
        ),
      );
    }
  }
}
