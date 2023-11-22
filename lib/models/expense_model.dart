class ExpenseModel {
  double amount;
  String? type;
  String? note;
  String dropdownData;

  ExpenseModel({
    required this.amount,
    this.type,
    this.note,
    required this.dropdownData,
  });
}
