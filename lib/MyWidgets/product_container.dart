import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/Models/product.dart';
import 'package:eshoppie/MyWidgets/cart_button.dart';
import 'package:eshoppie/MyWidgets/fade_in_image.dart';
import 'package:eshoppie/MyWidgets/like_button.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  final Product product;
  final products;
  final int productIndex;
  const ProductContainer(
      {Key? key,
      required this.product,
      required this.productIndex,
      required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 180,
      child: Stack(
        children: [
          //Black container
          Container(
            width: deviceWidth,
            height: double.infinity,
            decoration: BoxDecoration(
              color: K_blackColor,
              borderRadius: BorderRadius.circular(K_radius),
            ),
            child: Row(
              children: [
                Container(
                  width: deviceWidth! * 0.74,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: CartButton(
                              isCartProduct: product.inCart,
                              color: K_whiteColor,
                              productIndex: productIndex,
                              products: products)),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        color: K_greyColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      Expanded(
                          child: LikeButton(
                        isFavoriteProduct: product.inFavorites,
                        color: K_whiteColor,
                        productIndex: productIndex,
                        products: products,
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
          //White container
          Container(
            width: deviceWidth! * 0.74,
            height: double.infinity,
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: K_blackColor, width: 0.5),
              color: K_whiteColor,
              borderRadius: BorderRadius.circular(K_radius),
            ),
            child: Row(
              children: [
                Hero(
                  child: MyFadeInImage(imageURL: product.image),
                  tag: product.id,
                ),
                K_hSpace10,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: product.name,
                          size: K_fontSizeM + 3,
                          showEllipsis: true,
                          maxLinesNumber: 2,
                        ),
                        K_vSpace20,
                        MyText(
                          text: product.description,
                          size: K_fontSizeM - 3,
                          fontWeight: FontWeight.w400,
                          showEllipsis: true,
                          maxLinesNumber: 2,
                        ),
                        K_vSpace10,
                        MyText(
                          text: '${product.price} EGP',
                          size: K_fontSizeL - 2,
                          showEllipsis: true,
                          maxLinesNumber: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                K_hSpace10
              ],
            ),
          ),
        ],
      ),
    );
  }
}
