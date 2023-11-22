import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/themes/color_constants.dart';
import 'package:expense_tracker/themes/diamension.dart';
import 'package:expense_tracker/widgets/confirm_dialog.dart';
import 'package:expense_tracker/widgets/expense_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:hive/hive.dart';

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({super.key});
  @override
  State<StatefulWidget> createState() => ExpenseTabState();
}

class ExpenseTabState extends State<ExpenseTab> {
  late Box box;
  Map? data;
  bool hasData = false;
  @override
  void initState() {
    super.initState();
    box = Hive.box('money');
    fetch();
  }

  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error!'),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Please add your transactions"),
              );
            }
            return ListView(
              children: [
                ExpenseChart(),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (context, index) {
                      TransactionModel dataAtIndex;
                      try {
                        dataAtIndex = snapshot.data![index];
                      } catch (e) {
                        return Container();
                      }
                      if (dataAtIndex.type == 'Income') {
                        return Container();
                      } else {
                        return ExpenseTile(dataAtIndex.amount, dataAtIndex.note,
                            dataAtIndex.date, index);
                      }
                    })
              ],
            );
          } else {
            return const Center(
              child: Text("Error!"),
            );
          }
        });
  }
}

Widget ExpenseTile(int value, String note, DateTime date, int index) {
  return Container(
    margin: EdgeInsets.all(Diamensions.width8),
    padding: EdgeInsets.all(Diamensions.height20),
    decoration: BoxDecoration(
      color: ColorConstants.expenseTileRedColor,
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
                    size: Diamensions.icon14,
                    color: Colors.red[700],
                  ),
                  SizedBox(
                    width: Diamensions.width8,
                  ),
                  Text(
                    "Expense",
                    style: TextStyle(
                      color: ColorConstants.blackColor,
                      fontSize: Diamensions.font14,
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
                " - $value \₹",
                style: TextStyle(
                  color: ColorConstants.blackColor,
                  fontSize: Diamensions.font14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                note,
                style: TextStyle(
                  color: ColorConstants.blackColor,
                  fontSize: Diamensions.font12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        ]),
  );
}
