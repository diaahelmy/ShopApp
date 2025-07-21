import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/model/productmodel.dart';
import 'package:shopapp/screen/ProdectsItem.dart';

class ShopHomescreen extends StatefulWidget {
  const ShopHomescreen({super.key});

  @override
  State<ShopHomescreen> createState() => _ShopHomescreenState();
}

class _ShopHomescreenState extends State<ShopHomescreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeScreen, StatesShopHome>(
      listener: (context, state) {},
      buildWhen: (previous, current) {
        // مش كل الحالات تسبب rebuild
        return current is ProductLoadingState ||
            current is ProductSuccessState ||
            current is ProductErrorState;
      },
      builder: (context, state) {


        var cubit = CubitHomeScreen.get(context);

        if (state is ProductLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductSuccessState && cubit.products.isEmpty) {
          return const Center(child: Text("No data now"));
        } else if (state is ProductSuccessState) {
          return RefreshIndicator(
            onRefresh: () async {
              cubit.getProducts(forceRefresh: true); // Refresh logic
            },
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
                Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                const SizedBox(height: 10),
                Text(
                  "No Internet Connection",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    CubitHomeScreen.get(context).getProducts(forceRefresh: true);
                  },
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
  return Column(
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
              onTap: () {
                navigateTo(context, ProdectsItem(category: category));
              },
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
