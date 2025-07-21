import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopapp/core/theme/app_colors.dart';
import 'package:shopapp/log_addacount/cubit/Favorite/FavoriteCubit.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/log_addacount/cubit/cubitLogin.dart';
import 'package:shopapp/log_addacount/cubit/settings/SettingsCubit.dart';
import 'package:shopapp/log_addacount/cubit/themes/ThemeCubit.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/network/remote/dioHelper.dart';
import 'package:shopapp/on_board/on_Board_Screen.dart';
import 'package:shopapp/screen/ShopMainScreen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  DioHelper.init();
  await Cache.init();

  final themeCubit = ThemeCubit();
  final favoriteCubit = FavoriteCubit();

  await Future.delayed(const Duration(milliseconds: 100)); // optional delay
  await favoriteCubit.loadFavorites();

  final bool? onBoarding = Cache.getData(key: 'onBoarding') as bool?;
  final String? token = Cache.getData(key: 'token') as String?;

  final Widget startWidget = (onBoarding != null)
      ? (token != null ? const ShopMainScreen() :  LoginScreen())
      :  OnBoardScreen();
  FlutterNativeSplash.remove();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CubitHomeScreen>(
          create: (context) => CubitHomeScreen()
            ..getProducts()
            ..getCategories(),
        ),
        BlocProvider<ShopLoginCubit>(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider<FavoriteCubit>.value(
          value: favoriteCubit,
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit()..loadUserFromCache(),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
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
