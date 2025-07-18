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
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        CubitHomeScreen.get(context).loadMoreProducts();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeScreen, StatesShopHome>(
      builder: (BuildContext context, StatesShopHome state) {
        var cubit = CubitHomeScreen.get(context);
        return cubit.products.isNotEmpty
            ? productBuilder(
          context: context,
                scrollController: _scrollController,
                products: cubit.products,
                showCategories: true,
                categories: cubit.categories,
              )
            : const Center(child: CircularProgressIndicator());
      },
      listener: (BuildContext context, StatesShopHome state) {},
    );
  }
}

Widget buildCategoryList(List<CategoryModel> categories,BuildContext context) {
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
        child: buildHorizontalCategoryList(
          categories: categories, context: context,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
