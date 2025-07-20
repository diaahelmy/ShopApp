import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit, BlocProvider;
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/statusLogin.dart';
import 'package:shopapp/model/RegisterModel.dart';
import 'package:shopapp/model/ShopModelSignIn.dart';
import 'package:shopapp/network/endPoint.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/network/remote/dioHelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  UserModel? loginModel ;
  ShopLoginModel? loginModel2 ;
  static ShopLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((onValue) {
      loginModel2 =ShopLoginModel.fromJson(onValue.data);

      print(loginModel2?.access_token);
      emit(ShopLoginSuccessState(loginModel2!));

    }).catchError((error){
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          final errorMessage =  'Incorrect email or password';
          showToast(text: errorMessage, state: ToastStates.Error);
        } else {
          showToast(text: 'Login failed. Please try again.', state: ToastStates.Error);
        }
      } else {
        showToast(text: 'An unexpected error occurred.', state: ToastStates.Error);
      }

      emit(ShopLoginErrorState(error.toString()));
    });

  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String avatar

  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER, // الرابط أو المسار الخاص بالتسجيل
      data: {
        'avatar':avatar,
        "name": name,
        "email": email,
        "password": password,

      },
    ).then((value) {
      loginModel = UserModel.fromJson(value.data);
      print(loginModel?.access_token);
      Cache.saveData(key: 'userId', value: loginModel!.id);
      Cache.saveData(key: 'name', value: loginModel!.name);
      Cache.saveData(key: 'email', value: loginModel!.email);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      if (error is DioException) {
        if (error.response?.statusCode == 400) {
          final errorData = error.response?.data['message'];

          String errorMessage;
          if (errorData is List) {

            errorMessage = errorData.join('\n');
          } else {
            errorMessage = errorData?.toString() ?? 'Registration failed.';
          }

          showToast(text: errorMessage, state: ToastStates.Error);
        } else {
          showToast(text: 'Registration failed. Please try again.', state: ToastStates.Error);
        }
      } else {
        showToast(text: 'An unexpected error occurred.', state: ToastStates.Error);
      }
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


}
