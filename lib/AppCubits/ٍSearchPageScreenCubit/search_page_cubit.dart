import 'package:eshoppie/AppCubits/%D9%8DSearchPageScreenCubit/search_page_states.dart';
import 'package:eshoppie/Models/product.dart';
import 'package:eshoppie/api_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPageCubit extends Cubit<SearchPageStates> {
  SearchPageCubit() : super(SearchPageInitState());

  static SearchPageCubit get(context) => BlocProvider.of(context);

  //Search data
  List<Product> searchedProducts = [];

  getSearchedProducts(String text) async {
    emit(SearchPageLoadingProductsState());
    await APIHandler.dio!.post(APIHandler.getSearchedProducts,
        data: {"text": text}).then((value) {
      searchedProducts.clear();
      Product.fromJson(value.data['data']['data'], searchedProducts);
      emit(SearchPageGetProductsState());
    }).catchError((error) {
      emit(SearchPageErrorState());
      //No response error 404
    });
  }
}
