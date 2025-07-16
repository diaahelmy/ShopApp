import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/screen/FavoritesScreen.dart';
import 'package:shopapp/screen/SettingScreen.dart';
import 'package:shopapp/screen/ShopHomeScreen.dart';
import 'package:shopapp/screen/categoriesScreen.dart';

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
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }
}
