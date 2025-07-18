import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/model/productmodel.dart';

class ProdectsItem extends StatelessWidget {
  const ProdectsItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final clothesProducts = CubitHomeScreen.get(context).products
        .where(
          (product) =>
              product.category.name.toLowerCase() ==
              category.name.toLowerCase(),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        itemCount: clothesProducts.length,
        itemBuilder: (context, index) {
          return clothesProducts.isNotEmpty
              ? productBuilder(
                  scrollController: _scrollController,
                  products: clothesProducts,
                  showCategories: false,
            context: context
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
