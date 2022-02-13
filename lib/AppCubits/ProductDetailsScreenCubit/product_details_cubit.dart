import 'package:bloc/bloc.dart';
import 'package:eShoppie/AppCubits/ProductDetailsScreenCubit/product_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates>{

  ProductDetailsCubit() : super(ProductDetailsInitialState());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  int productAmount = 1;

  increaseAmount(){
    if(productAmount < 10) {
      productAmount++;
    }
    emit(IncreaseProductAmountState());
  }

  decreaseAmount(){
    if(productAmount > 1) {
      productAmount--;
    }
    emit(DecreaseProductAmountState());
  }

}