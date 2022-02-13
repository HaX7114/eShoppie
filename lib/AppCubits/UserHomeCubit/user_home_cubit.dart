import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:eShoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eShoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eShoppie/Models/categories.dart';
import 'package:eShoppie/Models/product.dart';
import 'package:eShoppie/Models/user.dart';
import 'package:eShoppie/Shared/shared_preference.dart';
import 'package:eShoppie/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_handler.dart';

class UserHomeCubit extends Cubit<UserHomeStates> {
  UserHomeCubit() : super(InitialUserHomeState());

  static UserHomeCubit get(context) => BlocProvider.of(context);

  //Bottom Navigation bar
  int currentIndex = 0;

  changeNavBarIndex(newIndex) {
    currentIndex = newIndex;
    emit(ChangeNavBarState());
  }

  //Get user data

  getUserData() async {
    await APIHandler.dio!
        .get(
      APIHandler.userProfile,
    )
        .then((value) {
      currentUserData = User.fromJson(value.data['data']);
      emit(GotUserDataState());
    }).catchError((error) {
      emit(ErrorUserDataState());
      //No response error 404
    });
  }

  //Product in favorites
  getFavoritesProducts() async {
    emit(GotProductsLoadingState());
    await APIHandler.dio!
        .get(
      APIHandler.getProductMethod,
    )
        .then((value) {
      products.clear();
      Product.fromFavorites(value.data['data']['data'], products);
      if (products.isNotEmpty) {
        emit(GotProductsState());
      } else {
        emit(NoFavoritesState());
      }
    }).catchError((error) {
      emit(GotProductsErrorState());
      //No response error 404
    });
  }

  //Like button product state
  bool isLikedProduct = false;

  changeLikeButtonState(bool isFavoriteProduct) {
    isLikedProduct = !isFavoriteProduct;
    emit(ChangeLikeButtonState());
    //update the backend will be here
  }

  addToFavorites(dynamic productID) async {
    await APIHandler.dio!.post(
      APIHandler.toFavorites,
      data: {'product_id': productID},
    ).then((value) {
      if (value.data['status']) {
        emit(AddedToFavState());
      } else {
        emit(ErrorWhileAddingToFav());
      }
    });
  }

  //Getting products function

  List<Product> products = [];

  getAllProductsOrSpecificCategory(int categoryID) async {
    if (categoryID == 0) {
      //0 means get all products
      getAllProducts();
    } else {
      getCategoryProducts(categoryID);
    }
  }

  getAllProducts() async {
    emit(GotProductsLoadingState());
    await APIHandler.dio!
        .get(
      APIHandler.getProductMethod,
    )
        .then((value) {
      products.clear();
      Product.fromJson(value.data['data']['data'], products);
      emit(GotProductsState());
    }).catchError((error) {
      emit(GotProductsErrorState());
      //No response error 404
    });
  }

  getCategoryProducts(int categoryID) async {
    emit(GotProductsLoadingState());
    await APIHandler.dio!
        .get(
      APIHandler.getCategoryMethod + '/$categoryID',
    )
        .then((value) {
      products.clear();
      Product.fromJson(value.data['data']['data'], products);
      emit(GotProductsState());
    }).catchError((error) {
      emit(GotProductsErrorState());
      //No response error 404
    });
  }

  //Getting categories function

  List<Category> categories = [];

  getAllCategories() async {
    if (categories.isEmpty) {
      emit(GotCategoriesLoadingState());
      await APIHandler.dio!
          .get(
        APIHandler.getCategoryMethod,
      )
          .then((value) {
        categories.add(Category(
            categoryID: 0,
            categoryImage: '',
            categoryName:
                'All Products')); //Default value to get all categories)
        Category.fromJson(value.data['data']['data'], categories);
        print(categories);
        emit(GotCategoriesState());
      }).catchError((error) {
        emit(GotCategoriesErrorState());
        //No response error 404
      });
    } else {
      emit(GotCategoriesState());
    }
  }
}
