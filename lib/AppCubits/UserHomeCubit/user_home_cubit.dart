import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:eshoppie/AppCubits/LoginScreenCubit/login_cubit.dart';
import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eshoppie/Models/address.dart';
import 'package:eshoppie/Models/cart.dart';
import 'package:eshoppie/Models/categories.dart';
import 'package:eshoppie/Models/product.dart';
import 'package:eshoppie/Models/user.dart';
import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  //Delete user address after sign out
  signUserOut() async {
    bool result = false;
    emit(SigningOutState());
    dynamic addressID =
        SharedHandler.getSharedPref(SharedHandler.saveAddressIDKey);
    result = await UserAddress.deleteAddress(addressID);
    if (result) {
      currentUserData = null; //Delete current user data
      emit(SignedOutState());
    } else {
      emit(ErrorSigningOutState());
    }
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

  //Product in carts
  getCartsProducts() async {
    emit(GotProductsLoadingState());
    await APIHandler.dio!
        .get(
      APIHandler.getProductMethod,
    )
        .then((value) {
      products.clear();
      Product.fromCarts(value.data['data']['data'], products);
      if (products.isNotEmpty) {
        emit(GotProductsState());
      } else {
        emit(NoCartsState());
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

  //Cart button product state
  bool isInCartProduct = false;

  changeCartButtonState(bool isCartProduct) {
    isInCartProduct = !isCartProduct;
    emit(ChangeCartButtonState());
  }

  addToCart(dynamic productID) async {
    bool status = false;
    await Cart.addToCart(productID, status);
    // ignore: dead_code
    if (status) {
      emit(AddedToCartState());
    } else {
      emit(ErrorWhileAddingToCart());
    }
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
