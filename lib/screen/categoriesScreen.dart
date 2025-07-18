import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/model/productmodel.dart';
import 'package:shopapp/screen/ProdectsItem.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, this.category});
  final CategoryModel? category;


  @override
  Widget build(BuildContext context) {
    final categories = CubitHomeScreen.get(context).categories;

     return Scaffold(
       body:   buildHorizontalCategoryList(
       categories: categories, context: context,
     ),
     );
  }
  }
