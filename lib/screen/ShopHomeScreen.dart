import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/network/local/Cache.dart';

class ShopHomescreen extends StatelessWidget {
  const ShopHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Shop',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: defaultButton(
        label: 'SignOut',
        onPressed: () {
          Cache.removeData(key: 'token').then((onValue) {
            navigateAndFinsh(context, LoginScreen());
          });
        },
      ),
    );
  }
}
