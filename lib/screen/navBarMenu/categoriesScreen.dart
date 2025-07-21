import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/model/productmodel.dart';
import 'package:shopapp/screen/ProdectsItem.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, this.category});

  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final categories = CubitHomeScreen.get(context).categories;

  return  BlocBuilder<CubitHomeScreen, StatesShopHome>(

      buildWhen: (previous, current) {
        // مش كل الحالات تسبب rebuild
        return current is CategoriesLoadingState ||
            current is CategoriesSuccessState ||
            current is CategoriesErrorState;
      },
      builder: (BuildContext context, StatesShopHome state) {
        if (state is CategoriesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesSuccessState && categories.isEmpty) {
          return const Center(child: Text("No data now"));
        } else if (state is CategoriesSuccessState) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                CubitHomeScreen.get(context).getCategories(forceRefresh: true);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      navigateTo(context, ProdectsItem(category: category));
                    },
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
                              maxLines: 2, // يخليه ينزل لسطر تاني لو محتاج
                              overflow: TextOverflow.ellipsis, // يحط ... لو النص أطول من كده
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
        }if (state is CategoriesErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                const SizedBox(height: 10),
                Text(
                  "Failed to load categories.",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () {
                    CubitHomeScreen.get(context).getCategories(forceRefresh: true);
                  },
                  child: Text("Retry"),
                ),
              ],
            ),
          );
        }

        // Initial or unknown state
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
