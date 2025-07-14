import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopHomescreen extends StatelessWidget {
  const ShopHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('My Shop',style: TextStyle(

          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
      ),
    );
  }
}
