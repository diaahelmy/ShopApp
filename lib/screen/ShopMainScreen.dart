import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/StatesShopHome.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';

class ShopmainScreen extends StatelessWidget {
  const ShopmainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeScreen, StatesShopHome>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CubitHomeScreen.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'My Shop',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: cubit.changeBottomNavBar,
          ),
        );
      },
    );
  }
}