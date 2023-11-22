import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});
  @override
  State<StatefulWidget> createState() {
    return _IncomeChartState();
  }
}

class _IncomeChartState extends State<IncomeChart> {
  late Box box;
  late List<IncomeModel> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late List<IncomeModel> incomeData;
  Map<String, double> totalExpenseByCategory = {};

  @override
  void initState() {
    box = Hive.box('money');
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chartData = fetchExpense();
    super.initState();
  }

  List<IncomeModel> fetchExpense() {
    if (box.values.isEmpty) {
      return [];
    } else {
      List<IncomeModel> incomeData = [];
      box.toMap().values.forEach((element) {
        if (element['type'] == "Income") {
          incomeData.add(IncomeModel(
              amount: element['amount'],
              type: element['type'],
              note: element['note']));
        }
      });

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
        DoughnutSeries<IncomeModel, String>(
          dataSource: _chartData,
          xValueMapper: (IncomeModel data, _) => data.note,
          yValueMapper: (IncomeModel data, _) => data.amount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          name: "Income",
          enableTooltip: true,
        ),
      ],
    );
  }
}
