import 'package:expense_tracker/pages/splash.dart';
import 'package:expense_tracker/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData(),
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      home: Splash(),
    );
  }
}
