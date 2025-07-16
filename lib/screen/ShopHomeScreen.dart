import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.grey.shade100],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0,6),
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
                childAspectRatio: 0.60,
              ),
              itemBuilder: (context, index) {
                final product = cubit.products[index];
                final image = (product.images.isNotEmpty)
                    ? product.images.first
                    : 'https://via.placeholder.com/400x300?text=No+Image';
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ صورة مربعة
                      Expanded(
                        flex: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: Colors.grey[300],
                                    child: Icon(Icons.broken_image, color: Colors.grey),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Material(
                                  color: isDark
                                      ? Colors.black.withOpacity(0.85)
                                      : Colors.white,
                                  shape: CircleBorder(),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 18,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      // ✅ تفاصيل تحت الصورة
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                ),
                              ),

                              SizedBox(height: 6),

                              Text(
                                '\$${product.price}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                );



              },
            ),
          ],
        ),
      ),
    );
  }
}
