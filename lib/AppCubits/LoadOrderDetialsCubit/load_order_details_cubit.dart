import 'package:bloc/bloc.dart';
import 'package:eshoppie/AppCubits/LoadOrderDetialsCubit/load_order_details_states.dart';
import 'package:eshoppie/AppCubits/MyOrdersScreenCubit/my_orders_states.dart';
import 'package:eshoppie/Models/order_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadOrderDetailsCubit extends Cubit<LoadOrderDetailsStates> {
  LoadOrderDetailsCubit() : super(LoadOrderDetailsInitState());

  static LoadOrderDetailsCubit get(context) => BlocProvider.of(context);

  OrderDetails? orderDetails;
  getOrderDetails(int id) async {
    dynamic result = 0;
    emit(LoadingOrderDetailsState());
    result = await OrderDetails.getOrderDetails(id);
    if (result != 0) {
      orderDetails = result;
      emit(LoadedOrderDetailsState());
    } else {
      emit(ErrorWhileLoadingOrderDetailsState());
    }
  }
}
