import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CalcBrain extends ChangeNotifier {
  Color primaryColor;

  void setColor() {
    //TODO: 계산 결과에 따라서 색 바꿔야함
  }

  //평단가 계산
  int calculateAverage(
      {String exSCount, String exSPrice, String newSCount, String newSPrice}) {
    int _exSCount = sanitizeComma(exSCount);
    int _exSPrice = sanitizeComma(exSPrice);
    int _newSCount = sanitizeComma(newSCount);
    int _newSPrice = sanitizeComma(newSPrice);
    var result = ((_exSCount * _exSPrice) + (_newSCount * _newSPrice)) /
        (_exSCount + _newSCount);

    String splitedNumber = result.toString().split('.')[0];
    int parsedNumber = int.parse(splitedNumber);

    return parsedNumber;
  }

  //수익률 계산
  double calculatePercent({String exStockPrice, int average}) {
    //수익률 = ((현재 주식 가격/매수 때 주식가격)-1)* 100
    double percent;
    int _exStockPrice = sanitizeComma(exStockPrice);
    percent = ((average / _exStockPrice) - 1) * 100;
    print(percent);

    return percent - percent % 0.01;
  }

  //차익 계산
  int calculateDiff({String exStockPrice, int average}) {
    return (average - sanitizeComma(exStockPrice));
  }

  //컴마 거르기 함수
  int sanitizeComma(String input) {
    List splitedInput;
    if (input.contains(',')) {
      splitedInput = input.split(',');
      String joinedInput = splitedInput.join("");
      return int.parse(joinedInput);
    } else if (input.contains('.')) {
      splitedInput = input.split('.');
      String joinedInput = splitedInput.join("");
      return int.parse(joinedInput);
    } else {
      return int.parse(input);
    }
  }
}
