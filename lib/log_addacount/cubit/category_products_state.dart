import 'package:shopapp/model/product_model.dart';

abstract class CategoryProductsState {}

class CategoryProductsInitial extends CategoryProductsState {}

class CategoryProductsLoading extends CategoryProductsState {}

class CategoryProductsSuccess extends CategoryProductsState {
  final List<ProductModel> products;
  final bool hasMoreData;

  CategoryProductsSuccess(this.products, this.hasMoreData);
}

class CategoryProductsError extends CategoryProductsState {
  final String message;

  CategoryProductsError(this.message);
}

class CategoryProductsLoadMore extends CategoryProductsState {
  final List<ProductModel> currentProducts;

  CategoryProductsLoadMore(this.currentProducts);
}

class CategoryProductsLoadMoreError extends CategoryProductsState {
  final List<ProductModel> currentProducts;

  CategoryProductsLoadMoreError(this.currentProducts);
}
