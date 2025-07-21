import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/states_shop_home.dart';
import 'package:shopapp/model/product_model.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

import 'package:shopapp/screen/navBarMenu/categories_screen.dart';
import 'package:shopapp/screen/navBarMenu/favorites_screen.dart';
import 'package:shopapp/screen/navBarMenu/setting_screen.dart';
import 'package:shopapp/screen/navBarMenu/shop_home_screen.dart';

class CubitHomeScreen extends Cubit<StatesShopHome> {
  CubitHomeScreen() : super(ShopInitialHomeStates());

  static CubitHomeScreen get(context) => BlocProvider.of(context);

  int currentIndex = 0;

final  List<BottomNavigationBarItem> bottomItems = [
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

  List<Widget> get  bottomScreen => [
    ShopHomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(allProducts:products,),
    SettingScreen(),
  ];


  void loadMoreProducts() {
    if (productsPerPage + 10 <= products.length) {
      productsPerPage += 10;
    } else {
      productsPerPage = products.length;
    }
    emit(ProductSuccessState());
  }

  void getProducts({bool forceRefresh = false}) {
    if (products.isEmpty || forceRefresh) {
      emit(ProductLoadingState());

      DioHelper.getData(url: PRODUCTS)
          .then((value) {

            products = (value.data as List)
                .map((e) => ProductModel.fromJson(e))
                .toList();

            productsPerPage = products.length >= 20 ? 20 : products.length;

            emit(ProductSuccessState());
          })
          .catchError((error) {
            emit(ProductErrorState(error.toString()));
          });
    } else {

    }
  }

  void getCategories({bool forceRefresh = false}) {
    if(categories.isEmpty|| forceRefresh) {
      emit(CategoriesLoadingState());

      DioHelper.getData(url: CATEGORIES)
          .then((value) {

        categories = (value.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        emit(CategoriesSuccessState());
      })
          .catchError((error) {
        emit(CategoriesErrorState(error.toString()));
      });
    }else{
    }
  }
}
