import 'package:flutter/material.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/model/productmodel.dart';

class ProdectsItem extends StatelessWidget {
  const ProdectsItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final clothesProducts = CubitHomeScreen.get(context)
        .products
        .where(
          (product) =>
      product.category.name.toLowerCase() ==
          category.name.toLowerCase(),
    )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: clothesProducts.isNotEmpty
          ? productBuilder(
        scrollController: _scrollController,
        products: clothesProducts,
        showCategories: false,
        showRecommendedTitle: false,
        context: context,
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
