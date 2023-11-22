import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/controllers/dp_helper.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/themes/color_constants.dart';
import 'package:expense_tracker/themes/diamension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRename extends StatefulWidget {
  const AddRename({super.key});

  @override
  State<StatefulWidget> createState() => _AddReNameState();
}

class _AddReNameState extends State<AddRename> {
  DbHelper dbHelper = DbHelper();
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConstants.backgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.blackColor,
            ),
            onPressed: () {
              Get.to(HomePage());
            },
          )),
      persistentFooterButtons: [
        Container(
          alignment: Alignment.center,
          child: Text(
            AppConstants.bottomText,
            style: context.textTheme.displaySmall!.copyWith(
              letterSpacing: 1,
              color: ColorConstants.greyColor,
            ),
          ),
        ),
      ],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Diamensions.width15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monetization_on_rounded,
                color: ColorConstants.purple,
                size: Diamensions.icon64,
              ),
              SizedBox(
                height: Diamensions.height20,
              ),
              Text(
                "Rename Your Name",
                style: context.textTheme.displayLarge!.copyWith(
                  color: ColorConstants.blackColor,
                ),
              ),
              SizedBox(
                height: Diamensions.height20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(
                    Diamensions.radius12,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Diamensions.radius12,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: InputBorder.none,
                      hintStyle: context.textTheme.displayMedium,
                    ),
                    style: context.textTheme.displayMedium!.copyWith(
                      color: ColorConstants.blackColor,
                    ),
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Diamensions.height20,
              ),
              GestureDetector(
                onTap: () async {
                  if (name.isEmpty) {
                    Get.snackbar(
                      "Name! Needed",
                      "Enter your name to continue",
                      colorText: ColorConstants.whiteColor,
                      backgroundColor: ColorConstants.purple,
                      icon: Icon(
                        Icons.person_2,
                        size: Diamensions.icon24,
                        color: ColorConstants.whiteColor,
                      ),
                    );
                  } else {
                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addName(name);
                    Get.to(() => const HomePage());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Diamensions.radius12,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        ColorConstants.blue,
                        ColorConstants.purple,
                        ColorConstants.orange
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Diamensions.height10),
                        child: Text(
                          "Let's Start",
                          style: context.textTheme.displayMedium!.copyWith(
                            color: ColorConstants.whiteColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Diamensions.width8,
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        size: Diamensions.icon24,
                        color: ColorConstants.whiteColor,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
