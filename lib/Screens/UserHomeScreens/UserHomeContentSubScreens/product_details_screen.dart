import 'package:eShoppie/AppCubits/ProductDetailsScreenCubit/product_details_cubit.dart';
import 'package:eShoppie/AppCubits/ProductDetailsScreenCubit/product_details_states.dart';
import 'package:eShoppie/Models/product.dart';
import 'package:eShoppie/MyWidgets/fade_in_image.dart';
import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/Shared/functions.dart';
import 'package:eShoppie/constants.dart';
import 'package:eShoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../user_home_content.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final int productIndex;
  const ProductDetails(
      {Key? key, required this.product, required this.productIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductDetailsCubit productCubit = ProductDetailsCubit.get(context);
          var multiplyResult = product.price * productCubit.productAmount;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: K_whiteColor.withOpacity(0.8),
              elevation: 0.0,
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end: K_mainPadding - 5, top: 5.0),
                  child: Icon(
                    product.inFavorites ? CupertinoIcons.suit_heart_fill : null,
                    color: K_blackColor,
                    size: 35.0,
                  ),
                ),
              ],
              leading: IconButton(
                  onPressed: () {
                    navigateBack(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: K_blackColor,
                    size: 28.0,
                  )),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      K_vSpace20,
                      K_vSpace20,
                      K_vSpace20,
                      K_vSpace20,
                      K_vSpace20,
                      Center(
                        child: SizedBox(
                          height: deviceHeight! * 0.5,
                          child: Hero(
                            tag: product.id,
                            child: PageView.builder(
                                controller: pageController,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: product.images.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.all(K_mainPadding),
                                    child: MyFadeInImage(
                                      imageURL: product.images[index],
                                      imageFit: BoxFit.contain,
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: product.images.length,
                        effect: const WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: K_blackColor,
                            dotColor: Colors.grey,
                            paintStyle: PaintingStyle.stroke
                            // strokeWidth: 5,
                            ),
                      ),
                      K_vSpace20,
                      //Column of name, description, ...
                      Padding(
                        padding: const EdgeInsets.all(K_mainPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: MyText(
                                  text: product.name,
                                  size: K_fontSizeL + 5,
                                )),
                                K_hSpace20,
                                Container(
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.4),
                                      borderRadius:
                                          BorderRadius.circular(K_radius)),
                                  padding:
                                      const EdgeInsets.all(K_mainPadding - 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            productCubit.decreaseAmount();
                                          },
                                          child: Icon(
                                            CupertinoIcons.minus,
                                            color: productCubit.productAmount !=
                                                    1
                                                ? K_blackColor
                                                : K_blackColor.withOpacity(0.2),
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                      K_hSpace10,
                                      MyText(
                                          text: '${productCubit.productAmount}',
                                          size: K_fontSizeL + 2),
                                      K_hSpace10,
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            productCubit.increaseAmount();
                                          },
                                          child: Icon(CupertinoIcons.plus,
                                              color: productCubit
                                                          .productAmount !=
                                                      10
                                                  ? K_blackColor
                                                  : K_blackColor.withOpacity(
                                                      0.2),
                                              size: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            K_vSpace20,
                            MyText(
                              text: product.description,
                              size: K_fontSizeM,
                              fontWeight: FontWeight.normal,
                            ),
                            K_vSpace20,
                            K_vSpace20,
                            K_vSpace20,
                            K_vSpace20,
                            K_vSpace20,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: K_mainPadding - 10,
                          end: K_mainPadding,
                          start: K_mainPadding,
                          top: K_mainPadding + 15),
                      height: 120,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.white, Colors.white12],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.4, 0.9])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Total Price',
                                size: K_fontSizeM,
                                fontWeight: FontWeight.normal,
                              ),
                              MyText(
                                  text:
                                      '${multiplyResult.toStringAsFixed(2)} EGP',
                                  size: K_fontSizeL + 2),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: shadow,
                              color: K_blackColor,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(K_radius + 10),
                                  bottomLeft: Radius.circular(K_radius - 5),
                                  topRight: Radius.circular(K_radius - 5),
                                  topLeft: Radius.circular(K_radius - 5)),
                            ),
                            height: 90,
                            width: 90,
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.shopping_cart,
                                  color: K_whiteColor,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
