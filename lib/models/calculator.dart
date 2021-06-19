import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CalcBrain extends ChangeNotifier {
  // int existingStocksPrice;
  // int existingStocksCount;
  // int newStocksPrice;
  // int newStocksCount;

  // String calcResult;

  // String priceDiff;

  Color primaryColor;

  // CalcBrain(
  //     {this.existingStocksCount,
  //     this.existingStocksPrice,
  //     this.newStocksCount,
  //     this.newStocksPrice});

  void setColor() {
    //TODO: 계산 결과에 따라서 색 바꿔야함
  }

  //평단가 계산
  int calculateAverage(
      {int exSCount, int exSPrice, int newSCount, int newSPrice}) {
    var result = ((exSCount * exSPrice) + (newSCount * newSPrice)) /
        (exSCount + newSCount);

    String splitedNumber = result.toString().split('.')[0];
    int parsedNumber = int.parse(splitedNumber);

    return parsedNumber;
  }

  //수익률 계산
  double calculatePercent({int exStockPrice, int average}) {
    //수익률 = ((현재 주식 가격/매수 때 주식가격)-1)* 100
    double percent;
    percent = ((average / exStockPrice) - 1) * 100;
    print(percent);

    return percent - percent % 0.01;
  }

  //차익 계산
  int calculateDiff({int exStockPrice, int average}) {
    return (average - exStockPrice);
  }

////
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  // void setPriceDiff(int diff) {
  //   //만약 음전이면 prefix에 -를 붙이고 양전이면 +를 붙일 것
  //   // 퍼센트 계산 결과도 넣어야함
  //   priceDiff = '${currencyFormat(diff)} 원';
  //   notifyListeners();
  // }

  // void clearPrice() {
  //   calcResult = '0 원';
  //   notifyListeners();
  // }

  //컴마 거르기 함수

  //TODO: 계산만 담당하도록 리팩터링
}
