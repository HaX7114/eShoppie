import 'package:bloc/bloc.dart';
import 'package:dio/src/response.dart';
import 'package:eShoppie/AppCubits/LoginScreenCubit/login_states.dart';
import 'package:eShoppie/Models/user.dart';
import 'package:eShoppie/Shared/shared_preference.dart';
import 'package:eShoppie/api_handler.dart';
import 'package:eShoppie/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

User? currentUserData;

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  int resultOfLogin = 0;

  loginUser(String email, String password) async {
    emit(AwaitLoginResultState());

    await APIHandler.dio!.post(APIHandler.loginMethod, data: {
      User.emailKey: email,
      User.passwordKey: password,
    }).then((value) async {
      if (value.data['status'] == true) {
        emit(LoggedSuccessfullyState());
        currentUserData = User.fromJson(value.data['data']);
        await SharedHandler.setSharedPref(
            SharedHandler.saveUserTokenKey, currentUserData!.token);
        //UPDATE THE Autoriaztion token value to be able to make any transactions which use it
        userTokenWhileSession = APIHandler.dio!.options.headers.update(
            APIHandler.authKey,
            (value) =>
                SharedHandler.getSharedPref(SharedHandler.saveUserTokenKey));
        resultOfLogin = 1;
      } else {
        emit(EmailOrPasswordIncorrectState());
        resultOfLogin = 2;
      }
    }).catchError((error) {
      print(error);
      emit(InternetConnectionErrorState());
      //No response error 404
      resultOfLogin = 3;
    });
  }
}
