class ShopLoginModel {
  String? message;
  String? access_token;
  String? refresh_token;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    message =json['message'];
    access_token=json['access_token'];
    refresh_token=json['refresh_token'];


  }
}

