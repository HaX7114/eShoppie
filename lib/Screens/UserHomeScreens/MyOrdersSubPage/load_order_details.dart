import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshoppie/AppCubits/LoadOrderDetialsCubit/load_order_details_cubit.dart';
import 'package:eshoppie/AppCubits/LoadOrderDetialsCubit/load_order_details_states.dart';
import 'package:eshoppie/AppCubits/MyOrdersScreenCubit/my_orders_cubit.dart';
import 'package:eshoppie/Models/order_details.dart';
import 'package:eshoppie/Models/product.dart';
import 'package:eshoppie/MyWidgets/icon_inside_container.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/MyWidgets/no_connection.dart';
import 'package:eshoppie/MyWidgets/order_details_product_container.dart';
import 'package:eshoppie/Shared/functions.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants.dart';

class LoadOrderDetails extends StatelessWidget {
  final orderID;
  const LoadOrderDetails({Key? key, required this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadOrderDetailsCubit()..getOrderDetails(orderID),
      child: BlocConsumer<LoadOrderDetailsCubit, LoadOrderDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoadOrderDetailsCubit orderDetailsCubit =
              LoadOrderDetailsCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: K_whiteColor.withOpacity(0.8),
                elevation: 0.0,
                title: MyText(text: 'Order Details', size: K_fontSizeL),
                centerTitle: true,
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
              body: ConditionalBuilder(
                condition: state is LoadingOrderDetailsState,
                builder: (context) => K_progressIndicator,
                fallback: (context) => ConditionalBuilder(
                  condition: state is LoadedOrderDetailsState,
                  builder: (context) {
                    OrderDetails orderD = orderDetailsCubit.orderDetails!;
                    return OrderDetailsWidget(
                      cost: orderD.cost,
                      date: orderD.date,
                      id: orderD.id,
                      parentCubit: orderDetailsCubit,
                      paymentMethod: orderD.paymentMethod,
                      products: orderD.products,
                      status: orderD.status,
                      total: orderD.total,
                      vat: orderD.vat,
                    );
                  },
                  fallback: (context) => const NoConnectionState(),
                ),
              ));
        },
      ),
    );
  }
}

class OrderDetailsWidget extends StatelessWidget {
  final id;
  final cost;
  final vat;
  final total;
  final paymentMethod;
  final date;
  final status;
  final LoadOrderDetailsCubit parentCubit;
  final List<Product>? products;
  const OrderDetailsWidget(
      {Key? key,
      required this.id,
      required this.cost,
      required this.date,
      required this.paymentMethod,
      required this.products,
      required this.status,
      required this.total,
      required this.vat,
      required this.parentCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: K_blackColor,
                      borderRadius: BorderRadius.circular(K_radius)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: 'Order # : $id',
                              size: K_fontSizeM,
                              fontWeight: FontWeight.normal,
                              color: K_whiteColor,
                            ),
                            MyText(
                              text: '$date',
                              fontWeight: FontWeight.normal,
                              size: K_fontSizeM,
                              color: K_whiteColor,
                            ),
                          ],
                        ),
                        K_vSpace20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const IconInsideContainer(
                                  size: 55.0,
                                  iconSize: 28.0,
                                  iconData:
                                      CupertinoIcons.money_dollar_circle_fill,
                                  borderColor: K_goldColor,
                                  iconColor: K_goldColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  text: 'C O S T',
                                  fontWeight: FontWeight.normal,
                                  size: K_fontSizeM,
                                  color: K_whiteColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  text: cost.toStringAsFixed(2) + '\nEGP',
                                  fontWeight: FontWeight.normal,
                                  size: K_fontSizeM - 2,
                                  color: K_goldColor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const IconInsideContainer(
                                  size: 55.0,
                                  iconSize: 28.0,
                                  iconData: CupertinoIcons.percent,
                                  borderColor: K_goldColor,
                                  iconColor: K_goldColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  text: 'V A T',
                                  fontWeight: FontWeight.normal,
                                  size: K_fontSizeM,
                                  color: K_whiteColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  fontWeight: FontWeight.normal,
                                  text: vat.toStringAsFixed(2) + '\nEGP',
                                  size: K_fontSizeM - 2,
                                  color: K_goldColor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const IconInsideContainer(
                                  size: 55.0,
                                  iconSize: 28.0,
                                  iconData: CupertinoIcons.add_circled_solid,
                                  borderColor: K_goldColor,
                                  iconColor: K_goldColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  text: 'T O T A L',
                                  fontWeight: FontWeight.normal,
                                  size: K_fontSizeM,
                                  color: K_whiteColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  fontWeight: FontWeight.normal,
                                  text: total.toStringAsFixed(2) + '\nEGP',
                                  size: K_fontSizeM - 2,
                                  color: K_goldColor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconInsideContainer(
                                  size: 55.0,
                                  iconSize: 28.0,
                                  iconData: paymentMethod == 'Cash'
                                      ? Ionicons.cash
                                      : CupertinoIcons.creditcard_fill,
                                  borderColor: K_goldColor,
                                  iconColor: K_goldColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  text: 'P A Y',
                                  fontWeight: FontWeight.normal,
                                  size: K_fontSizeM,
                                  color: K_whiteColor,
                                ),
                                K_vSpace10,
                                MyText(
                                  fontWeight: FontWeight.normal,
                                  text: '$paymentMethod\n',
                                  size: K_fontSizeM - 2,
                                  color: K_goldColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            K_vSpace20,
            K_vSpace20,
            Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return OrderDetailsProductContainer(
                      cartID: 0,
                      qty: parentCubit.orderDetails!.products![index].qty,
                      imageURL:
                          parentCubit.orderDetails!.products![index].image,
                      productName:
                          parentCubit.orderDetails!.products![index].name,
                      productPrice:
                          parentCubit.orderDetails!.products![index].price,
                      productQuantity:
                          parentCubit.orderDetails!.products![index].qty,
                      parentCubit: parentCubit,
                    );
                  },
                  separatorBuilder: (context, index) => K_vSpace20,
                  itemCount: parentCubit.orderDetails!.products!.length,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
