import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/network/local/Cache.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
        'Setting Screen Content',
        style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 25,),
        defaultButton(
          label: 'SignOut',
          onPressed: () {
            Cache.removeData(key: 'token').then((onValue) {
              navigateAndFinsh(context, LoginScreen());
            });
          },
        ),
      ],
    ),
    );
  }
}
