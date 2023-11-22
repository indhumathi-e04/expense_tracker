import 'package:expense_tracker/themes/color_constants.dart';
import 'package:expense_tracker/themes/diamension.dart';
import 'package:expense_tracker/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTiles extends StatelessWidget {
  int value;
  String note;
  DateTime date;
  int index;
  ExpenseTiles(
      {required this.value,
      required this.note,
      required this.date,
      required this.index,
      super.key});

  get dbHelper => null;

  @override
  Widget build(BuildContext context) {
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
              }
            },
          ),
        ],
      ),
      child: Container(
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
      ),
    );
  }
}
