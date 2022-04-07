import 'package:dio/dio.dart';

class APIHandler {
  static Dio? dio;

  static Map<String, dynamic> headers = {
    APIHandler.languageKey: APIHandler.languageValue,
    APIHandler.contentTypeKey: APIHandler.contentTypeValue,
    APIHandler.authKey: ''
  };

  //Url & Methods
  static String baseURL = 'https://student.valuxapps.com/api/';
  static String loginMethod = 'login';
  static String signUpMethod = 'register';
  static String getProductMethod = 'products';
  static String getCategoryMethod = 'categories';
  static String toFavorites = 'favorites';
  static String toCarts = 'carts';
  static String orders = 'orders';
  static String addresses = 'addresses';
  static String userProfile = 'profile';
  static String userLogout = 'logout';
  static String getSearchedProducts = 'products/search';
  //Header Keys
  static String languageKey = 'lang';
  static String contentTypeKey = 'Content-Type';
  static String authKey = 'Authorization';
  //Languages
  static String arabic = 'ar';
  static String english = 'en';
  //Header Values
  static String languageValue = english;
  static String contentTypeValue = 'application/json';

  static initializeAPI() {
    dio = Dio(BaseOptions(
      baseUrl: baseURL,
      headers: headers,
      receiveDataWhenStatusError: true,
    ));
    print('This is the auth key : ');
    print(dio!.options.headers[authKey]);
    print('API Initialized');
  }
}
