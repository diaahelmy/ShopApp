
import 'package:shopapp/model/register_model.dart';
import 'package:shopapp/model/shop_model_signIn.dart';

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
