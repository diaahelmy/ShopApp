import 'package:flutter/material.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/network/remote/dioHelper.dart';
import 'package:shopapp/on_board/on_Board_Screen.dart';
import 'package:shopapp/themes/ThemesLightandDark.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Cache.init();
  bool onBoarding = Cache.getData(key: 'onBoarding');
  runApp( MyApp(onBoarding: onBoarding));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;

   MyApp({ this.onBoarding});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onBoarding! ? LoginScreen() :OnBoardScreen(),

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
