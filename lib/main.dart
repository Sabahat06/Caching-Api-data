import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/product_controller.dart';
import 'package:untitled/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductController wishListController = Get.put(ProductController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caching Api Data',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      home: ProductScreen(),
    );

  }
}
