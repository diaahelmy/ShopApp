import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/componant/shop_app_componat.dart';

import 'package:shopapp/log_addacount/cubit/shop_home_viewmodel.dart';
import 'package:shopapp/log_addacount/cubit/states_shop_home.dart';
import 'package:shopapp/model/product_model.dart';
import 'package:shopapp/screen/prodects_item.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, this.category});

  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final categories = CubitHomeScreen.get(context).categories;

    return BlocBuilder<CubitHomeScreen, StatesShopHome>(
      buildWhen: (previous, current) =>
      current is CategoriesLoadingState ||
          current is CategoriesSuccessState ||
          current is CategoriesErrorState,
      builder: (BuildContext context, StatesShopHome state) {
        if (state is CategoriesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoriesErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                const SizedBox(height: 10),
                Text(
                  "Failed to load categories.",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () =>
                      CubitHomeScreen.get(context).getCategories(forceRefresh: true),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        if (state is CategoriesSuccessState && categories.isEmpty) {
          return const Center(child: Text("No data now"));
        }

        if (state is CategoriesSuccessState) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async =>
                  CubitHomeScreen.get(context).getCategories(forceRefresh: true),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () =>
                        navigateTo(context, ProdectsItem(category: category)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(category.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
