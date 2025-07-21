import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/componant/shop_app_componat.dart';
import 'package:shopapp/log_addacount/cubit/shop_home_viewmodel.dart';
import 'package:shopapp/log_addacount/cubit/states_shop_home.dart';
import 'package:shopapp/model/product_model.dart';
import 'package:shopapp/screen/prodects_item.dart';

class ShopHomeScreen extends StatefulWidget {
  const ShopHomeScreen({super.key});

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeScreen, StatesShopHome>(
      listener: (context, state) {},
      buildWhen: (previous, current) {
        return current is ProductLoadingState ||
            current is ProductSuccessState ||
            current is ProductErrorState;
      },
      builder: (context, state) {


        var cubit = CubitHomeScreen.get(context);

        if (state is ProductSuccessState) {
          return RefreshIndicator(
            onRefresh: () async => cubit.getProducts(forceRefresh: true),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels >=
                    scrollNotification.metrics.maxScrollExtent - 200) {
                  cubit.loadMoreProducts();
                }
                return false;
              },
              child: productBuilder(
                context: context,
                scrollController: _scrollController,
                products: cubit.products.take(cubit.productsPerPage).toList(),
                showCategories: true,
                categories: cubit.categories,
              ),
            ),
          );
        } else if (state is ProductErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                const SizedBox(height: 10),
                Text(
                  "No Internet Connection",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
               onPressed: () => cubit.getProducts(forceRefresh: true),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }
        // Initial or unknown state
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget buildCategoryListHome(
  List<CategoryModel> categories,
  BuildContext context,
) {
  return Column (
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(
          'Categories',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () => navigateTo(context, ProdectsItem(category: category)),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),

                      child: Image.network(category.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(category.name, style: GoogleFonts.poppins(fontSize: 12)),
                ],
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
