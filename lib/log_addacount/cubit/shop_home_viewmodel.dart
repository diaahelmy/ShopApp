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

  final List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category_rounded), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  bool loadMoreError = false;

  List<CategoryModel> categories = [];

  List<ProductModel> products = [];

  List<Widget> get bottomScreen => [
    ShopHomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(allProducts: products),
    SettingScreen(),
  ];

  bool isLoadingMore = false;
  bool hasMoreData = true;
  int offset = 0;
  final int limit = 10;


  void getProducts({bool forceRefresh = false}) {
    if (forceRefresh) {
      products.clear();
      offset = 0;
      hasMoreData = true;
    }

    emit(ProductLoadingState());

    DioHelper.getData(url: "$PRODUCTS?limit=$limit&offset=$offset")
        .then((value) {
      List<ProductModel> newProducts = (value.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      if (newProducts.length < limit) {
        hasMoreData = false; // مفيش صفحات تانية
      }

      products.addAll(newProducts);
      offset += newProducts.length;

      emit(ProductSuccessState());
    }).catchError((error) {
      emit(ProductErrorState(error.toString()));
    });
  }

  /// تحميل المزيد
  void loadMoreProducts() {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    loadMoreError = false;
    emit(ProductLoadMoreState());

    DioHelper.getData(url: "$PRODUCTS?limit=$limit&offset=$offset")
        .then((value) {
      List<ProductModel> newProducts = (value.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      if (newProducts.isEmpty) {
        hasMoreData = false;
      } else {
        products.addAll(newProducts);
        offset += newProducts.length;
      }

      isLoadingMore = false;
      emit(ProductSuccessState());
    }).catchError((error) {
      isLoadingMore = false;
      loadMoreError = true; // حصل خطأ في التحميل
      emit(ProductSuccessState()); // نبقى في نفس الحالة بس نعرض الخطأ تحت
    });
  }

  void getCategories({bool forceRefresh = false}) {
    if (categories.isEmpty || forceRefresh) {
      emit(CategoriesLoadingState());

      DioHelper.getData(url: CATEGORIES)
          .then((value) {
        categories = (value.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        emit(CategoriesSuccessState());
      }).catchError((error) {
        emit(CategoriesErrorState(error.toString()));
      });
    }
  }
}
