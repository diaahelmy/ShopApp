import 'package:flutter/material.dart';
import 'package:shopapp/on_board/on_Board_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardScreen(),
        // 'images/assets/image/Layer 1.png'
      // title:  'VISIT OUR\nONLINE SHOP',
      // subtitle  'We have millions of one-of-a-kind items, so you can find\nwhatever you need for you or anyone you love.',
    );
  }
}
