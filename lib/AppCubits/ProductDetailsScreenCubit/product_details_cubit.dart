import 'package:bloc/bloc.dart';
import 'package:eshoppie/AppCubits/ProductDetailsScreenCubit/product_details_states.dart';
import 'package:eshoppie/Models/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);
}
