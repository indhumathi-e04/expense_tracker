import 'package:expense_tracker/controllers/dp_helper.dart';
import 'package:expense_tracker/pages/add_name.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/themes/color_constants.dart';
import 'package:expense_tracker/themes/diamension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DbHelper dbHelper = DbHelper();
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getName();
  }

  Future getName() async {
    preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString('name');

    if (name != null) {
      Get.to(() => const HomePage());
    } else {
      Get.to(() => AddName());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.backgroundColor,
            borderRadius: BorderRadius.circular(Diamensions.radius12),
          ),
          padding: EdgeInsets.all(Diamensions.width15),
          child: Icon(
            Icons.monetization_on_rounded,
            color: ColorConstants.purple,
            size: Diamensions.icon64,
          ),
        ),
      ),
    );
  }
}
