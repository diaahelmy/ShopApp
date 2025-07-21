import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componant/shop_app_componat.dart';
import 'package:shopapp/log_addacount/cubit/shop_home_viewmodel.dart';
import 'package:shopapp/log_addacount/cubit/states_shop_home.dart';
import 'package:shopapp/model/product_model.dart';


class ProdectsItem extends StatelessWidget {
  const ProdectsItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final clothesProducts = CubitHomeScreen
        .get(context)
        .products
        .where(
          (product) =>
      product.category.name.toLowerCase() ==
          category.name.toLowerCase(),
    )
        .toList();
    return BlocBuilder<CubitHomeScreen, StatesShopHome>(
      builder: (BuildContext context, StatesShopHome state) {
        return Scaffold(
          appBar: AppBar(title: Text(category.name)),
          body: clothesProducts.isEmpty
              ? const Center(child: Text("No data now"))
              : productBuilder(
            scrollController: scrollController,
            products: clothesProducts,
            showCategories: false,
            showRecommendedTitle: false,
            context: context,
          ),
        );
      },);
  }
}
