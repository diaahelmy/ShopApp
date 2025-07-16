import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/cubitHomeScreen.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/network/remote/dioHelper.dart';
import 'package:shopapp/on_board/on_Board_Screen.dart';
import 'package:shopapp/screen/ShopHomeScreen.dart';
import 'package:shopapp/screen/ShopMainScreen.dart';
import 'package:shopapp/themes/ThemesLightandDark.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Cache.init();
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
      BlocProvider(
        create: (context) => CubitHomeScreen(),
        child: MyApp(startWidget: widget),
      ),
  );
}

class MyApp extends StatelessWidget {
  final Widget ? startWidget;

   MyApp({ this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
