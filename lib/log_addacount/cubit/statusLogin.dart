import 'package:shopapp/model/RegisterModel.dart';
import 'package:shopapp/model/ShopModelSignIn.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopRegisterLoadingState extends ShopLoginStates {}

class ShopRegisterSuccessState extends ShopLoginStates {
  final UserModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopLoginStates {
  final String error;

  ShopRegisterErrorState(this.error);
}
