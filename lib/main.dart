import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/home/home.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Home(),
    );
  }
}
