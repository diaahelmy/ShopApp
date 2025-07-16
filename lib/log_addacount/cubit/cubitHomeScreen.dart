import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/model/productmodel.dart';
import 'package:shopapp/network/remote/dioHelper.dart';
import 'package:shopapp/screen/FavoritesScreen.dart';
import 'package:shopapp/screen/SettingScreen.dart';
import 'package:shopapp/screen/ShopHomeScreen.dart';
import 'package:shopapp/screen/categoriesScreen.dart';
import 'package:shopapp/network/endPoint.dart';

class CubitHomeScreen extends Cubit<StatesShopHome> {
  CubitHomeScreen() : super(ShopInitialHomeStates());

  static CubitHomeScreen get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget>bottomScreen = [
    ShopHomescreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_rounded),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  List<ProductModel> products = [];
  int productsPerPage = 20;
  void loadMoreProducts() {
    if (productsPerPage + 20 <= products.length) {
      productsPerPage += 20;
    } else {
      productsPerPage = products.length;
    }
    emit(ProductSuccessState());
  }
  void getProducts() {
    emit(ProductLoadingState());

    DioHelper.getData(url: PRODUCTS).then((value) {
      print('API Response: ${value.data}');

      products = (value.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      emit(ProductSuccessState());
    }).catchError((error) {
      print('Error: $error');
      emit(ProductErrorState(error.toString()));
    });
  }
}
