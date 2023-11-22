import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  late Box box;
  late SharedPreferences preferences;

  DbHelper() {
    openBox();
  }
  openBox() {
    box = Hive.box("money");
  }

  void addData(
    int amount,
    DateTime date,
    String type,
    String note,
    String dropdownData,
  ) {
    var value = {
      'amount': amount,
      'date': date,
      'type': type,
      'note': note,
      'dropdownData': dropdownData
    };
    box.add(value);
  }

  Future deleteData(int index) async {
    await box.deleteAt(index);
  }

  Future clearData() async {
    await box.clear();
  }

  addName(String name) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('name', name);
  }

  getName() async {
    preferences = await SharedPreferences.getInstance();
    preferences.getString('name');
  }
}
