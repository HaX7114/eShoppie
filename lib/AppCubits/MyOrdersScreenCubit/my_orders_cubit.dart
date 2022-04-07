import 'package:bloc/bloc.dart';
import 'package:eshoppie/AppCubits/MyOrdersScreenCubit/my_orders_states.dart';
import 'package:eshoppie/AppCubits/UserOrderDetailsCubit/user_order_details_states.dart';
import 'package:eshoppie/Models/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersCubit extends Cubit<MyOrdersStates> {
  MyOrdersCubit() : super(MyOrdersInitState());

  static MyOrdersCubit get(context) => BlocProvider.of(context);

  List<Order> orders = [];

  getOrderDetails() async {
    int result = 0;
    emit(LoadingOrdersState());
    result = await Order.getAllOrders(orders);
    if (result == 0) {
      emit(LoadedOrdersButEmptyState());
    } else if (result == 1) {
      emit(LoadedOrdersState());
    } else {
      emit(ErrorWhileLoadingOrdersState());
    }
  }

  getAllOrders() async {
    int result = 0;
    emit(LoadingOrdersState());
    result = await Order.getAllOrders(orders);
    if (result == 0) {
      emit(LoadedOrdersButEmptyState());
    } else if (result == 1) {
      emit(LoadedOrdersState());
    } else {
      emit(ErrorWhileLoadingOrdersState());
    }
  }
}
