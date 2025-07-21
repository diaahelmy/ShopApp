import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/shop_home_viewmodel.dart';
import 'package:shopapp/log_addacount/cubit/states_shop_home.dart';

class ShopMainScreen extends StatelessWidget {
  const ShopMainScreen({super.key});

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
          body: IndexedStack(
            index: cubit.currentIndex,
            children: cubit.bottomScreen,
          ),
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