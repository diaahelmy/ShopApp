import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componant/shop_app_componat.dart';
import 'package:shopapp/log_addacount/cubit/category_products_cubit.dart';
import 'package:shopapp/log_addacount/cubit/category_products_state.dart';
import 'package:shopapp/model/product_model.dart';


class ProdectsItem extends StatelessWidget {
  const ProdectsItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryProductsCubit()..fetchProducts(category.id),
      child: BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
        builder: (context, state) {
          final cubit = CategoryProductsCubit.of(context);

          if (state is CategoryProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CategoryProductsError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }

          if (cubit.products.isEmpty) {
            return const Center(child: Text("No data now"));
          }

          return Scaffold(
            appBar: AppBar(title: Text(category.name)),
            body: RefreshIndicator(
              onRefresh: () async =>
                  cubit.fetchProducts(category.id, forceRefresh: true),
              child: productBuilder(
                scrollController: ScrollController()
                  ..addListener(() {
                    if (state is! CategoryProductsLoadMore &&
                        cubit.hasMoreData &&
                        cubit.isLoadingMore == false) {
                      cubit.loadMoreProducts(category.id);
                    }
                  }),
                products: cubit.products,
                showCategories: false,
                showRecommendedTitle: false,
                isLoadingMore: cubit.isLoadingMore,
                loadMoreError: state is CategoryProductsLoadMoreError,
                context: context,
              ),
            ),
          );
        },
      ),
    );
  }
}
