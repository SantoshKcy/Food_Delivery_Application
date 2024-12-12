import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/loading_page_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => const LoadingPageView()},
    ),
  );
}
