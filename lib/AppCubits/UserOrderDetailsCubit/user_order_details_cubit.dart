import 'package:eshoppie/AppCubits/UserOrderDetailsCubit/user_order_details_states.dart';
import 'package:eshoppie/Models/cart.dart';
import 'package:eshoppie/Models/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderDetailsCubit extends Cubit<UserOrderDetailsStates> {
  UserOrderDetailsCubit() : super(UserOrderDetailsInitState());

  static UserOrderDetailsCubit get(context) => BlocProvider.of(context);

  List<Cart> userCartProducts = [];
  double total = 0.0;

  getCartsProducts() async {
    emit(CartProductsLoadingState());
    await Cart.getCartData(userCartProducts);
    if (userCartProducts.isEmpty) {
      emit(CartErrorState());
    } else {
      calcTotal(userCartProducts);
      emit(GotCartProductsState());
    }
  }

  calcTotal(List<Cart> userCartProducts) {
    for (var element in userCartProducts) {
      total = total + (element.product!.price * element.quantity);
    }
  }

  //Setting an order
  setOrder(int paymentMethod) async {
    emit(SettingTheOrderState());
    await Order.setOrder(paymentMethod).then((value) {
      emissionCheck(value, OrderSetSuccessState(), OrderNotSetFailState());
    });
  }

  emissionCheck(condition, state1, state2) {
    if (condition) {
      emit(state1);
    } else {
      emit(state2);
    }
  }

  //updateTotal used while the user updated a qty before he places the order
  updateTotalByIncreasing(productTotalPriceQty) {
    total = total + productTotalPriceQty;
    emit(IncreaseTotalAmountState());
  }

  updateTotalByDecreasing(productTotalPriceQty) {
    total = total - productTotalPriceQty;
    emit(DecreaseTotalAmountState());
  }

  //Used in order details bottom sheet page to control the amount of qty
  dynamic productQuantity = 0;
  dynamic productPrice = 0;
  dynamic productTotalPriceQty = 0;

  setProductQuantity(productQty) {
    productQuantity = productQty;
  }

  setProductPrice(productPrc) {
    productPrice = productPrc;
  }

  setProductPriceQty(productTotalPQ) {
    productTotalPriceQty = productTotalPQ;
  }

  increaseAmount(cartID, parentCubit) async {
    productQuantity++;
    emit(LoadingWhileChangingTheAmount());
    await Cart.updateCartData(cartID, productQuantity).then((value) async {
      if (value) {
        productTotalPriceQty = productTotalPriceQty + productPrice;
        parentCubit.updateTotalByIncreasing(productPrice);
        emit(IncreaseProductAmountState());
      } else {
        productQuantity--; //return to default by decreasing
        emit(ErrorWhileChangingTheAmount());
      }
    }).catchError((error) {
      emit(ErrorWhileChangingTheAmount());
    });
  }

  decreaseAmount(cartID, parentCubit) async {
    productQuantity--;
    emit(LoadingWhileChangingTheAmount());
    await Cart.updateCartData(cartID, productQuantity).then((value) async {
      if (value) {
        productTotalPriceQty = productTotalPriceQty - productPrice;
        parentCubit.updateTotalByDecreasing(productPrice);
        emit(DecreaseProductAmountState());
      } else {
        productQuantity++; //return to default by increasing
        emit(ErrorWhileChangingTheAmount());
      }
    }).catchError((error) {
      emit(ErrorWhileChangingTheAmount());
    });
  }
}
