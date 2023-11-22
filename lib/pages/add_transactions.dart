import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/controllers/dp_helper.dart';
import 'package:expense_tracker/themes/color_constants.dart';
import 'package:expense_tracker/themes/diamension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<StatefulWidget> createState() => AddTransactionState();
}

class AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "";
  String types = "Income";
  DateTime sdate = DateTime.now();
  String dropdownValue = "Food";
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  var items = [
    "Food",
    "Entertainment",
    "Tarvel",
    "Shopping",
  ];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: sdate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != sdate) {
      setState(() {
        sdate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstants.blackColor,
          ),
        ),
        title: Text(
          "Add Transactions",
          style: context.textTheme.displayLarge!.copyWith(
            fontSize: Diamensions.font20,
            color: ColorConstants.blackColor,
          ),
        ),
        centerTitle: true,
      ),
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
        )
      ],
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: Diamensions.height10 + 2,
            vertical: Diamensions.height30,
          ),
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Diamensions.height30 + Diamensions.height60,
              ),
              padding: EdgeInsets.only(
                left: Diamensions.height60,
                right: Diamensions.height30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Diamensions.height60),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "\₹",
                      style: TextStyle(
                        fontSize: Diamensions.font20,
                        color: ColorConstants.greyColor,
                      ),
                    ),
                    SizedBox(
                      width: Diamensions.width8,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: Diamensions.font20,
                            color: ColorConstants.greyColor),
                        onChanged: (val) {
                          try {
                            amount = int.parse(val);
                          } catch (e) {}
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: Diamensions.height30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Diamensions.width8,
                horizontal: Diamensions.height10,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.circular(Diamensions.radius30),
              ),
              child: Row(children: [
                Container(
                  padding: EdgeInsets.only(
                    left: Diamensions.width12,
                    right: Diamensions.width12,
                    top: Diamensions.width12,
                    bottom: Diamensions.width12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ColorConstants.blue,
                        ColorConstants.purple,
                        ColorConstants.orange,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      Diamensions.radius30,
                    ),
                  ),
                  child: Icon(
                    Icons.description,
                    size: Diamensions.width12,
                    color: ColorConstants.whiteColor,
                  ),
                ),
                SizedBox(
                  width: Diamensions.height10,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Note",
                      hintStyle: context.textTheme.displaySmall!.copyWith(
                        color: ColorConstants.greyColor,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: Diamensions.font20 - 4,
                    ),
                    onChanged: (val) {
                      note = val;
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: Diamensions.height20,
            ),
            Row(children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      ColorConstants.blue,
                      ColorConstants.purple,
                      ColorConstants.orange,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    Diamensions.radius25,
                  ),
                ),
                padding: EdgeInsets.all(Diamensions.width8),
                child: Icon(
                  Icons.moving_sharp,
                  size: Diamensions.width15,
                  color: ColorConstants.whiteColor,
                ),
              ),
              SizedBox(
                width: Diamensions.height10 + 2,
              ),
              ChoiceChip(
                selectedColor: ColorConstants.purple,
                label: Text("Income",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: Diamensions.font14,
                      //fontWeight: FontWeight.bold,
                      color: types == "Income"
                          ? ColorConstants.whiteColor
                          : ColorConstants.blackColor,
                    )),
                selected: types == "Income" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      types = "Income";
                      if (note.isEmpty || note == "Expense") {
                        note = 'Income';
                      }
                    });
                  }
                },
              ),
              SizedBox(
                width: Diamensions.height10 + 2,
              ),
              ChoiceChip(
                selectedColor: ColorConstants.purple,
                label: Text("Expense",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: Diamensions.font14,
                      //fontWeight: FontWeight.bold,
                      color: types == "Expense"
                          ? ColorConstants.whiteColor
                          : ColorConstants.blackColor,
                    )),
                selected: types == "Expense" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      types = "Expense";
                      if (note.isEmpty || note == "Expense") {
                        note = "Expense";
                      }
                    });
                  }
                },
              ),
            ]),
            SizedBox(
              height: Diamensions.height10,
            ),
            SizedBox(
              height: Diamensions.height30 + 20,
              child: TextButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            ColorConstants.blue,
                            ColorConstants.purple,
                            ColorConstants.orange,
                          ],
                          begin: Alignment.topLeft,
                        ),
                        borderRadius: BorderRadius.circular(
                          Diamensions.radius25,
                        ),
                      ),
                      padding: EdgeInsets.all(Diamensions.width12),
                      child: Icon(
                        Icons.date_range,
                        size: Diamensions.icon14,
                        color: ColorConstants.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: Diamensions.height10 + 2,
                    ),
                    Text(
                      "${sdate.day} ${months[sdate.month - 1]}",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontSize: Diamensions.font12,
                        color: ColorConstants.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Diamensions.height20,
            ),
            Visibility(
              visible: types != "Income",
              child: DropdownButton(
                underline: null,
                menuMaxHeight: 130,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(left: 12),
                borderRadius: BorderRadius.circular(30),
                elevation: 0,
                value: dropdownValue,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorConstants.greyColor,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: ColorConstants.blackColor),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: Diamensions.height20,
            ),
            GestureDetector(
              onTap: () {
                if (amount != null) {
                  DbHelper dbHelper = DbHelper();
                  dbHelper.addData(amount!, sdate, types, note, dropdownValue);
                  Get.back();
                } else {
                  Get.snackbar(
                    "Add Amount",
                    "Enter amount to continue",
                    colorText: ColorConstants.whiteColor,
                    backgroundColor: ColorConstants.purple,
                    icon: Icon(
                      Icons.monetization_on,
                      size: Diamensions.icon24,
                      color: ColorConstants.whiteColor,
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      ColorConstants.blue,
                      ColorConstants.purple,
                      ColorConstants.orange,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Diamensions.height10 + 5),
                      child: Text(
                        "Add",
                        style: context.textTheme.displayMedium!
                            .copyWith(color: ColorConstants.whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
