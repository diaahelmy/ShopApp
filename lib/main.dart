import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/core/theme/app_theme.dart';
import 'package:shopapp/log_addacount/cubit/Favorite/favorite_cubit.dart';
import 'package:shopapp/log_addacount/cubit/cubit_login.dart';
import 'package:shopapp/log_addacount/cubit/settings/settings_cubit.dart';
import 'package:shopapp/log_addacount/cubit/shop_home_viewmodel.dart';
import 'package:shopapp/log_addacount/login_screen.dart';
import 'package:shopapp/log_addacount/cubit/themes/theme_cubit.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/on_board/on_board_screen.dart';
import 'package:shopapp/screen/shop_main_screen.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Cache.init();

  final themeCubit = ThemeCubit();
  final favoriteCubit = FavoriteCubit();

  await Future.delayed(const Duration(milliseconds: 100)); // optional delay
  await favoriteCubit.loadFavorites();

  final bool? onBoarding = Cache.getData(key: 'onBoarding') as bool?;
  final String? token = Cache.getData(key: 'token') as String?;

  final Widget startWidget = (onBoarding != null)
      ? (token != null ? const ShopMainScreen() : LoginScreen())
      : OnBoardScreen();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CubitHomeScreen>(
          create: (context) => CubitHomeScreen()
            ..getProducts()
            ..getCategories(),
        ),
        BlocProvider<ShopLoginCubit>(create: (context) => ShopLoginCubit()),
        BlocProvider<FavoriteCubit>.value(value: favoriteCubit),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit()..loadUserFromCache(),
        ),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: MyApp(startWidget: startWidget, themeCubit: themeCubit),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final ThemeCubit themeCubit;

  const MyApp({required this.startWidget, required this.themeCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: themeCubit,
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeCubit.currentThemeMode,
          );
        },
      ),
    );
  }
}
