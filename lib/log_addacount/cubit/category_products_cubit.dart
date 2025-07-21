import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/category_products_state.dart';
import 'package:shopapp/model/product_model.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  CategoryProductsCubit() : super(CategoryProductsInitial());

  static CategoryProductsCubit of(BuildContext context) =>
      BlocProvider.of(context);

  final int limit = 10;
  int offset = 0;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  List<ProductModel> products = [];

  Future<void> fetchProducts(int categoryId, {bool forceRefresh = false}) async {
    if (forceRefresh) {
      products.clear();
      offset = 0;
      hasMoreData = true;
    }

    emit(CategoryProductsLoading());

    try {
      final data = await DioHelper.getData(
        url: "$PRODUCTS?limit=$limit&offset=$offset&category=$categoryId",
      );

      final newProducts = (data.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      if (newProducts.length < limit) hasMoreData = false;

      products.addAll(newProducts);
      offset += newProducts.length;

      emit(CategoryProductsSuccess(products, hasMoreData));
    } catch (e) {
      emit(CategoryProductsError(e.toString()));
    }
  }

  Future<void> loadMoreProducts(int categoryId) async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    emit(CategoryProductsLoadMore(products));

    try {
      final data = await DioHelper.getData(
        url: "$PRODUCTS?limit=$limit&offset=$offset&category=$categoryId",
      );

      final newProducts = (data.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      if (newProducts.isEmpty) {
        hasMoreData = false;
      } else {
        products.addAll(newProducts);
        offset += newProducts.length;
      }

      emit(CategoryProductsSuccess(products, hasMoreData));
    } catch (e) {
      emit(CategoryProductsLoadMoreError(products));
    } finally {
      isLoadingMore = false;
    }
  }
}
