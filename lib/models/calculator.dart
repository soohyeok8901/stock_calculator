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
    priceDiff = '${currencyFormat(parsedNumber - exSPrice.toInt())} 원';
    notifyListeners();
  }

  void setPriceDiff(int diff) {
    //만약 음전이면 prefix에 -를 붙이고 양전이면 +를 붙일 것
    // 퍼센트 계산 결과도 넣어야함
    priceDiff = '${currencyFormat(diff)} 원';
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
