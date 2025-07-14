import 'package:flutter_bloc/flutter_bloc.dart' show Cubit, BlocProvider;
import 'package:shopapp/log_addacount/cubit/status.dart';
import 'package:shopapp/model/ShopModelSignIn.dart';
import 'package:shopapp/network/endPoint.dart';
import 'package:shopapp/network/remote/dioHelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  ShopLoginModel? loginModel ;

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData (
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((onValue) {
      loginModel =ShopLoginModel.fromJson(onValue.data);
      print(loginModel?.message);

      emit(ShopLoginSuccessState(loginModel!));

    }).catchError((onError){
      print('Error: $onError');

      emit(ShopLoginErrorState(onError.toString()));

    });
  }
}
