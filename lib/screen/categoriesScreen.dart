import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:
    Column(
    children: [
    // Image.network(product.image ?? placeholder),
    Text('CategoriesScreen.title', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('CategoriesScreen.description'),
    Text('السعر: \$${'10000'}'),

    ],
    ),
    );

  }
}
