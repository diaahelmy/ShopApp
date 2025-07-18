import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/model/productmodel.dart';
import 'package:shopapp/network/remote/dioHelper.dart';
import 'package:shopapp/network/endPoint.dart';
import 'package:shopapp/screen/navBarMenu/FavoritesScreen.dart';
import 'package:shopapp/screen/navBarMenu/SettingScreen.dart';
import 'package:shopapp/screen/navBarMenu/ShopHomeScreen.dart';
import 'package:shopapp/screen/navBarMenu/categoriesScreen.dart';

class CubitHomeScreen extends Cubit<StatesShopHome> {
  CubitHomeScreen() : super(ShopInitialHomeStates());

  static CubitHomeScreen get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ShopHomescreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_rounded),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  List<CategoryModel> categories = [];

  List<ProductModel> products = [];
  int productsPerPage = 10;

  void loadMoreProducts() {
    if (productsPerPage + 10 <= products.length) {
      productsPerPage += 10;
    } else {
      productsPerPage = products.length;
    }
    emit(ProductSuccessState());
  }

  void getProducts() {
    emit(ProductLoadingState());

    DioHelper.getData(url: PRODUCTS)
        .then((value) {
          print('API Response: ${value.data}');

          products = (value.data as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();

          productsPerPage = products.length >= 20 ? 20 : products.length;

          emit(ProductSuccessState());
        })
        .catchError((error) {
          print('Error: $error');
          emit(ProductErrorState(error.toString()));
        });
  }

  void getCategories() {
    emit(CategoriesLoadingState());

    DioHelper.getData(url: CATEGORIES)
        .then((value) {
          print('Categories API Response: ${value.data}');

          categories = (value.data as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList();

          emit(CategoriesSuccessState());
        })
        .catchError((error) {
          print('Categories Error: $error');
          emit(CategoriesErrorState(error.toString()));
        });
  }
}
