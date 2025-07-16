import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/log_addacount/cubit/cubitHomeScreen.dart';
import 'package:shopapp/model/productmodel.dart';

class ShopHomescreen extends StatefulWidget {
  const ShopHomescreen({super.key});

  @override
  State<ShopHomescreen> createState() => _ShopHomescreenState();
}

class _ShopHomescreenState extends State<ShopHomescreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        CubitHomeScreen.get(context).loadMoreProducts();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeScreen, StatesShopHome>(
      builder: (BuildContext context, StatesShopHome state) {
        var cubit = CubitHomeScreen.get(context);
        return ConditionalBuilder(
          condition: cubit.products.isNotEmpty,
          builder: (context) => productBuilder(cubit),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, StatesShopHome state) {},
    );
  }

  Widget productBuilder(CubitHomeScreen cubit) {
    final random = Random();
    final allProducts = cubit.products;

    // لو أقل من 5 منتجات في الـ API
    if (allProducts.length <= 5) {
      // خدهم كلهم بس
      final images = allProducts
          .map((product) => product.images.first)
          .toList();

      return buildCarousel(images, cubit);
    }

    // لو أكثر من 5، اختار 5 عشوائيين بدون تكرار
    final selectedProducts = <ProductModel>{};
    while (selectedProducts.length < 5) {
      selectedProducts.add(allProducts[random.nextInt(allProducts.length)]);
    }

    final imageUrls = selectedProducts
        .map((product) => product.images.first)
        .toList();

    return buildCarousel(imageUrls, cubit);
  }

  Widget buildCarousel(List<String> imageUrls, CubitHomeScreen cubit) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Carousel
            CarouselSlider(
              items: imageUrls.map((imageUrl) {
                final validImage = (imageUrl.isNotEmpty)
                    ? imageUrl
                    : 'https://shop.techart-usa.com/cdn/shop/files/992143Models1.jpg?v=1692170889&width=533';

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      validImage,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 220,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
              ),
            ),

            SizedBox(height: 16),


            //  Grid View للمنتجات
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cubit.productsPerPage,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = cubit.products[index];
                final image = (product.images.isNotEmpty)
                    ? product.images.first
                    : 'https://via.placeholder.com/400x300?text=No+Image';

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          image,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[300],
                            height: 140,
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${product.price}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }}
