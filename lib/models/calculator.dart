import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CalcBrain extends ChangeNotifier {
  double existingStocksPrice;
  int existingStocksCount;
  double newStocksPrice;
  int newStocksCount;

  String calcResult;

  CalcBrain(
      {this.existingStocksCount,
      this.existingStocksPrice,
      this.newStocksCount,
      this.newStocksPrice});

  void calcAverage(
      {int exSCount, double exSPrice, int newSCount, double newSPrice}) {
    double result = ((exSCount * exSPrice) + (newSCount * newSPrice)) /
        (exSCount + newSCount);

    String splitNumber = result.toString().split('.')[0];
    int parsedNumber = int.parse(splitNumber);
    calcResult = '${currencyFormat(parsedNumber)} 원';
    print('calcResult - $calcResult');
    notifyListeners();
  }

  void clearPrice() {
    calcResult = '0 원';
    notifyListeners();
  }

  String currencyFormat(int price) {
    print(price);
    final formatCurrency = new NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return formatCurrency.format(price);
    // print(formatCurrency.format(calcResult));
    // notifyListeners();
  }
}
