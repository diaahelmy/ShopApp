import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componant/shop_app_componat.dart';
import 'package:shopapp/log_addacount/cubit/Favorite/favorite_cubit.dart';
import 'package:shopapp/log_addacount/cubit/Favorite/favorite_state.dart';
import 'package:shopapp/model/product_model.dart';


class FavoritesScreen extends StatelessWidget {
  final List<ProductModel> allProducts;


  const FavoritesScreen({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, favState) {
        final favoriteProducts = allProducts
            .where((product) => favState.favoriteIds.contains(product.id))
            .toList();

        return Scaffold(
          body: favoriteProducts.isEmpty
              ? const Center(child: Text('No favorites yet'))
              : productBuilder(
            products: favoriteProducts,
            scrollController: ScrollController(),
            context: context,
            showCategories: false,
            showRecommendedTitle: false,
          ),
        );
      },
    );
  }
  }