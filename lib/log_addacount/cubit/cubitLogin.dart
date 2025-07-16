import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit, BlocProvider;
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/statusLogin.dart';
import 'package:shopapp/model/ShopModelSignIn.dart';
import 'package:shopapp/network/endPoint.dart';
import 'package:shopapp/network/remote/dioHelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  ShopLoginModel? loginModel ;

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((onValue) {
      loginModel =ShopLoginModel.fromJson(onValue.data);
      print(loginModel?.access_token);

      emit(ShopLoginSuccessState(loginModel!));

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




}
