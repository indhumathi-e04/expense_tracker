import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/controllers/dp_helper.dart';
import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/pages/add_rename.dart';
import 'package:expense_tracker/pages/add_transactions.dart';
import 'package:expense_tracker/pages/income_expense.dart';
import 'package:expense_tracker/themes/color_constants.dart';
import 'package:expense_tracker/themes/diamension.dart';
import 'package:expense_tracker/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box box;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  bool hasDate = false;
  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;
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
    "Dec"
  ];
  @override
  void initState() {
    super.initState();
    getPreference();
    box = Hive.box('money');
    fetch();
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        print(element);
        items.add(
          TransactionModel(
              element['amount'] as int,
              element['note'],
              element['date'] as DateTime,
              element['type'],
              element['dropdownData']),
        );
      });
      return items;
    }
  }

  getTotalBalance(List<TransactionModel> entiredata) {
    totalExpense = 0;
    totalIncome = 0;
    totalBalance = 0;

    for (TransactionModel data in entiredata) {
      if (data.type == "Income") {
        totalBalance += data.amount;
        totalIncome += data.amount;
      } else {
        totalBalance -= data.amount;
        totalExpense -= data.amount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const AddTransaction(),
              ),
            )
                .whenComplete(() {
              setState(() {});
            });
          },
          tooltip: "Add Transations",
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            Diamensions.radius25,
          )),
          child: Container(
            width: Diamensions.height60,
            height: Diamensions.height60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  ColorConstants.blue,
                  ColorConstants.purple,
                  ColorConstants.orange,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.add,
              color: ColorConstants.whiteColor,
              size: Diamensions.icon24,
            ),
          ),
        ),
        body: dbHelper.box.isNotEmpty
            ? FutureBuilder(
                future: fetch(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error!"),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Please add your transactions!"),
                      );
                    }
                    getTotalBalance(snapshot.data!);
                    return ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Diamensions.width15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorConstants.orange,
                                        borderRadius: BorderRadius.circular(
                                          Diamensions.radius25,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(Diamensions.width8),
                                        child: Icon(
                                          Icons.person,
                                          size: Diamensions.icon24,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Diamensions.width8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome!",
                                          style: context.textTheme.displayLarge!
                                              .copyWith(
                                            fontSize: Diamensions.font12,
                                            color: ColorConstants.greyColor,
                                          ),
                                        ),
                                        Text(
                                          "${preferences.getString('name')}",
                                          style: context.textTheme.displayLarge!
                                              .copyWith(
                                            fontSize: Diamensions.font20,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Diamensions.radius12),
                                    color: ColorConstants.whiteColor
                                        .withOpacity(0.5),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.settings,
                                      size: Diamensions.icon24,
                                      color: ColorConstants.greyColor,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => AddRename(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.all(
                            Diamensions.height10,
                          ),
                          child: Container(
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    Diamensions.radius25,
                                  ),
                                )),
                            padding: EdgeInsets.symmetric(
                              vertical: Diamensions.height20,
                              horizontal: Diamensions.height10,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppConstants.totalBalance,
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.displayLarge!.copyWith(
                                    fontSize: Diamensions.font20,
                                    color: ColorConstants.whiteColor,
                                  ),
                                ),
                                SizedBox(
                                  height: Diamensions.height10,
                                ),
                                Text(
                                  totalBalance <= 0
                                      ? "0 \$"
                                      : "$totalBalance \$",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    color: ColorConstants.whiteColor,
                                    fontSize: Diamensions.font26,
                                  ),
                                ),
                                SizedBox(
                                  height: Diamensions.height10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                    Diamensions.width8,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CardIncome(totalIncome.toString()),
                                        CardExpense(totalExpense.toString())
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                Diamensions.height10,
                              ),
                              child: Text(
                                AppConstants.recentTransactions,
                                style: context.textTheme.displayLarge!.copyWith(
                                  fontSize: Diamensions.font26,
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(Diamensions.height10),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => IncomeExpense());
                                },
                                child: Text("View all"),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length + 1,
                            itemBuilder: (context, index) {
                              TransactionModel dataAtIndex;
                              try {
                                dataAtIndex = snapshot.data![index];
                              } catch (e) {
                                return Container();
                              }

                              if (dataAtIndex.type == "Income") {
                                return IncomeTile(dataAtIndex.amount,
                                    dataAtIndex.note, dataAtIndex.date, index);
                              } else {
                                return ExpenseTile(dataAtIndex.amount,
                                    dataAtIndex.note, dataAtIndex.date, index);
                              }
                            }),
                        SizedBox(
                          height: Diamensions.height30 * 2,
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("Error!"),
                    );
                  }
                })
            : FutureBuilder(
                future: fetch(),
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Diamensions.height20,
                      vertical: Diamensions.height20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstants.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(Diamensions.width8),
                                    child: Icon(
                                      Icons.person,
                                      size: Diamensions.icon24,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Diamensions.width8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome",
                                      style: context.textTheme.displayLarge!
                                          .copyWith(
                                        fontSize: Diamensions.font12,
                                        color: ColorConstants.greyColor,
                                      ),
                                    ),
                                    Text(
                                      "${preferences.getString('name')}",
                                      style: context.textTheme.displayLarge!
                                          .copyWith(
                                        fontSize: Diamensions.font20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Diamensions.radius12),
                                color:
                                    ColorConstants.whiteColor.withOpacity(0.5),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  size: Diamensions.font20,
                                  color: ColorConstants.greyColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => AddRename()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Diamensions.height300,
                        ),
                        Text(AppConstants.noTransactions),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget CardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.circular(Diamensions.radius30),
          ),
          padding: EdgeInsets.all(Diamensions.width8),
          margin: EdgeInsets.only(
            right: Diamensions.width8,
          ),
          child: Icon(
            Icons.arrow_upward,
            size: Diamensions.icon24,
            color: Colors.green,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Income",
              style: TextStyle(
                fontSize: Diamensions.font20,
                color: ColorConstants.whiteColor,
              ),
            ),
            Text(
              "$value \$",
              style: TextStyle(
                fontSize: Diamensions.font20,
                fontWeight: FontWeight.w700,
                color: ColorConstants.whiteColor,
              ),
            ),
          ],
        )
      ],
    );
  }

  //////////////////////////
  Widget CardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.circular(
              Diamensions.radius30,
            ),
          ),
          padding: EdgeInsets.all(Diamensions.width8),
          margin: EdgeInsets.only(right: Diamensions.width8),
          child: Icon(
            Icons.arrow_downward,
            size: Diamensions.icon24,
            color: Colors.red[700],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expense",
              style: TextStyle(
                fontSize: Diamensions.font20,
                color: ColorConstants.whiteColor,
              ),
            ),
            Text(
              "$value \$",
              style: TextStyle(
                fontSize: Diamensions.font20,
                fontWeight: FontWeight.w700,
                color: ColorConstants.whiteColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  //////////////////////
  Widget ExpenseTile(int value, String note, DateTime date, int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
            onPressed: (context) async {
              bool? answer = await showConfirmDialog(
                context,
                "WARNING",
                "This will delete this expense record. This action is irreversible. Do you want to continue?",
              );
              if (answer != null && answer) {
                await dbHelper.deleteData(index);
                setState(() {});
              }
            },
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(Diamensions.width8),
        padding: EdgeInsets.all(Diamensions.height20),
        decoration: BoxDecoration(
          color: const Color(0xfffacc5),
          borderRadius: BorderRadius.circular(Diamensions.radius25),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_down_outlined,
                        size: Diamensions.icon24,
                        color: Colors.red[700],
                      ),
                      SizedBox(
                        width: Diamensions.width8,
                      ),
                      Text(
                        "Expense",
                        style: TextStyle(
                          fontSize: Diamensions.font20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(Diamensions.width8),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    " - $value \$",
                    style: TextStyle(
                      fontSize: Diamensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    note,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: Diamensions.font12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }

  ///////////////
  Widget IncomeTile(int value, String note, DateTime date, int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
            onPressed: (context) async {
              bool? answer = await showConfirmDialog(
                context,
                "WARNING",
                "This will delete this expense record. This action is irreversible. Do you want to continue?",
              );
              if (answer != null && answer) {
                await dbHelper.deleteData(index);
                setState(() {});
              }
            },
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(Diamensions.width8),
        padding: EdgeInsets.all(Diamensions.height20),
        decoration: BoxDecoration(
          color: const Color(0xffd8fac5),
          borderRadius: BorderRadius.circular(Diamensions.radius25),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_down_outlined,
                        size: Diamensions.icon24,
                        color: Colors.green[700],
                      ),
                      SizedBox(
                        width: Diamensions.width8,
                      ),
                      Text(
                        "Income",
                        style: TextStyle(
                          fontSize: Diamensions.font20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(Diamensions.width8),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    " - $value \$",
                    style: TextStyle(
                      fontSize: Diamensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    note,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: Diamensions.font12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
