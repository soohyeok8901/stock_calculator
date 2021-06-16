import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CalcBrain extends ChangeNotifier {
  double existingStocksPrice;
  int existingStocksCount;
  double newStocksPrice;
  int newStocksCount;

  String calcResult;

  String priceDiff;

  Color primaryColor;

  CalcBrain(
      {this.existingStocksCount,
      this.existingStocksPrice,
      this.newStocksCount,
      this.newStocksPrice});

  void setColor() {
    //TODO: 계산 결과에 따라서 색 바꿔야함
  }

  void calcAverage(
      {int exSCount, double exSPrice, int newSCount, double newSPrice}) {
    double result = ((exSCount * exSPrice) + (newSCount * newSPrice)) /
        (exSCount + newSCount);

    String splitNumber = result.toString().split('.')[0];
    int parsedNumber = int.parse(splitNumber);
    calcResult = '${currencyFormat(parsedNumber)} 원';
    // priceDiff = (exSPrice - int.parse(calcResult)).toString();
    // print('calcResult - $calcResult');
    // calcResult.toString();
    notifyListeners();
  }

  void clearPrice() {
    calcResult = '0 원';
    notifyListeners();
  }

  String currencyFormat(int price) {
    // print(price);
    final formatCurrency = new NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return formatCurrency.format(price);
    // print(formatCurrency.format(calcResult));
    // notifyListeners();
  }
}
