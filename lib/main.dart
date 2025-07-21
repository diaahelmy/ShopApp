import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Cache.init();
  final themeCubit = ThemeCubit();
  final favoriteCubit = FavoriteCubit();
  await Future.delayed(const Duration(milliseconds: 100)); // optional delay for loading

  await favoriteCubit.loadFavorites();
  bool? onBoarding = Cache.getData(key: 'onBoarding') as bool?;
  String? token = Cache.getData(key: 'token') as String?;

  Widget widget;

  if(onBoarding != null){
    if(token != null){
      widget = ShopmainScreen();
    }else{
      widget = LoginScreen();
    }

  }else{
    widget = OnBoardScreen();
  }
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
        // BlocProvider<AnotherCubit>(create: (context) => AnotherCubit()), // لو عايز تضيف Cubits تانية
      ],
      child: MyApp(startWidget: widget, themeCubit: themeCubit,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget ? startWidget;
  final ThemeCubit themeCubit;
   MyApp({ this.startWidget, required this.themeCubit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: themeCubit,
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (BuildContext context, state) { return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: startWidget,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeCubit.currentThemeMode,
        ); },

      ),
    );
  }
}
