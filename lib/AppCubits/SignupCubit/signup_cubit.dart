import 'package:bloc/bloc.dart';
import 'package:eshoppie/AppCubits/SignupCubit/signup_states.dart';
import 'package:eshoppie/Models/user.dart';
import 'package:eshoppie/api_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignupStates> {
  SignUpCubit() : super(InitialSignupState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  int resultOfSignUp = 0;
  String? message;

  signUpUser(
      String username, String email, String password, String? phone) async {
    emit(AwaitSignupResultState());

    await APIHandler.dio!.post(APIHandler.signUpMethod, data: {
      User.nameKey: username,
      User.emailKey: email,
      User.passwordKey: password,
      User.phoneNumberKey: phone,
    }).then((value) {
      if (value.data['status']) {
        emit(SignedUpSuccessfullyState());
        resultOfSignUp = 1;
      } else {
        emit(ErrorWhileSigningUpState());
        resultOfSignUp = 2;
        message = value.data['message'];
      }
    }).catchError((error) {
      emit(InternetConnectionErrorState());
      //No response error 404
      resultOfSignUp = 3;
    });
  }
}
