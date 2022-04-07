import 'package:eshoppie/AppCubits/UserOrderDetailsCubit/user_order_details_cubit.dart';
import 'package:eshoppie/Models/product.dart';
import 'package:eshoppie/api_handler.dart';

class Cart {
  int? cartID;
  int? quantity;
  Product? product;

  Cart({this.cartID, this.quantity, this.product});

  Cart.fromJson(List<dynamic> cartData, List<Cart> userCartProducts) {
    for (var element in cartData) {
      userCartProducts.add(
        Cart(
          cartID: element['id'],
          quantity: element['quantity'],
          product: Product(
            id: element['product']['id'],
            description: element['product']['description'],
            image: element['product']['image'],
            images: element['product']['images'],
            inCart: element['product']['in_cart'],
            inFavorites: element['product']['in_favorites'],
            name: element['product']['name'],
            price: element['product']['price'],
          ),
        ),
      );
    }
  }

  static getCartData(List<Cart> userCartProducts) async {
    await APIHandler.dio!
        .get(
      APIHandler.toCarts,
    )
        .then((value) {
      Cart.fromJson(value.data['data']['cart_items'], userCartProducts);
    }).catchError((error) {
      //No response error 404
    });
  }

  static addToCart(productID, bool status) async {
    await APIHandler.dio!.post(
      APIHandler.toCarts,
      data: {'product_id': productID},
    ).then((value) {
      status = value.data['status'];
    });
  }

  static Future<bool> updateCartData(cartID, qty) async {
    bool status = false;
    await APIHandler.dio!.put(APIHandler.toCarts + '/' + cartID.toString(),
        data: {"quantity": qty}).then((value) {
      status = value.data['status'];
    }).catchError((error) {
      //No response error 404
    });
    return status;
  }
}
