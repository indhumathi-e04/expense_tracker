import 'package:expense_tracker/pages/tabBar/expense_tab.dart';
import 'package:expense_tracker/pages/tabBar/income_tab.dart';
import 'package:expense_tracker/themes/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeExpense extends StatefulWidget {
  const IncomeExpense({super.key});

  @override
  State<IncomeExpense> createState() => IncomeExpenseState();
}

class IncomeExpenseState extends State<IncomeExpense> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.backgroundColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text("Transactions"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.whiteColor,
                ),
                child: TabBar(
                  indicatorPadding: EdgeInsets.only(
                    left: -70,
                    right: -70,
                  ),
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ColorConstants.blue,
                        ColorConstants.purple,
                        ColorConstants.orange,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelColor: ColorConstants.whiteColor,
                  unselectedLabelColor: ColorConstants.blackColor,
                  tabs: [
                    Tab(
                      text: "Income",
                    ),
                    Tab(
                      text: "Expense",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    incomeTab(),
                    ExpenseTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
