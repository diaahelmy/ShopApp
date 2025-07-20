import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/model/productmodel.dart';

class Productdetailsscreen extends StatelessWidget {
  final ProductModel product;

  const Productdetailsscreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitHomeScreen, StatesShopHome>(
      builder: (BuildContext context, StatesShopHome state) {
        return Scaffold(
          appBar: AppBar(title: Text(product.title)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة المنتج
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.network(product.images.first),
                ),
                const SizedBox(height: 16),

                // الاسم والسعر
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${product.price} ',
                  style: const TextStyle(fontSize: 18, color: Colors.orange),
                ),
                const SizedBox(height: 16),

                // وصف المنتج
                Text(product.description ?? 'No description available'),
                const Spacer(),

                // زر
                SizedBox(
                  width: double.infinity,
                  child: defaultButton(onPressed: () {}, label: 'Add to Cart'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
