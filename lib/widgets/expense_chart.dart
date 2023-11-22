import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpenseChartState();
  }
}

class _ExpenseChartState extends State<ExpenseChart> {
  late Box box;
  late List<ExpenseModel> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late List<ExpenseModel> incomeData;
  Map<String, double> totalExpenseByCategory = {};

  @override
  void initState() {
    box = Hive.box('money');
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chartData = fetchExpense();
    super.initState();
  }

  List<ExpenseModel> fetchExpense() {
    if (box.values.isEmpty) {
      return [];
    } else {
      List<ExpenseModel> incomeData = [];
      box.toMap().values.forEach((element) {
        print(element.toString() + "  elements printed");
        totalExpenseByCategory.putIfAbsent(element['dropdownData'], () => 0);
        totalExpenseByCategory[element['dropdownData']] =
            totalExpenseByCategory[element['dropdownData']]! +
                element['amount'];
      });
      for (var item in totalExpenseByCategory.entries) {
        incomeData
            .add(ExpenseModel(amount: item.value, dropdownData: item.key));
      }
      return incomeData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <DoughnutSeries>[
        DoughnutSeries<ExpenseModel, String>(
          dataSource: _chartData,
          xValueMapper: (ExpenseModel data, _) => data.dropdownData,
          yValueMapper: (ExpenseModel data, _) => data.amount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          name: "Income",
          enableTooltip: true,
        ),
      ],
    );
  }
}
