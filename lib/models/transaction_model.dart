class TransactionModel {
  int amount;
  final String note;
  final DateTime date;
  final String type;
  final String dropdownData;
  totalAmountByCategory(int amount) {
    this.amount = this.amount + amount;
  }

  TransactionModel(
      this.amount, this.note, this.date, this.type, this.dropdownData);
}
