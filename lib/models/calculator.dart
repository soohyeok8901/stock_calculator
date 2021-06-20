import 'package:flutter/cupertino.dart';

class CalcBrain extends ChangeNotifier {
  Color primaryColor;

  Color setColor() {
    //TODO: 계산 결과에 따라서 색 바꿔야함
  }

  String setEmoji() {
    //TODO: 계산 결과에 따라서 이모지 리턴
  }

  /// TODO:<계산 해야 하는 정보>
  /// 수익률 = (평가손익 / 매입총액) * 100
  /// 평가손익 = 평가총액 - 평단가 * 수량
  /// 평가손익 = 평가총액 - 매입총액
  /// 매입총액 = 평단가 * 수량
  ///
  /// ++++++
  /// 어떻게 해야 추가 물타기 계산 구현을 할 수 있는가.
  ///

  //매입총액 계산 = 평가총액 - 매입총액
  int calculateTotalPurchase({String purchasePrice, String holdingQuantity}) {
    return sanitizeComma(purchasePrice) * sanitizeComma(holdingQuantity);
  }

  //평가손익 계산 = 평가총액 - 매입총액
  int calculateValuation({String totalValuationPrice, int totalPurchase}) {
    return (sanitizeComma(totalValuationPrice) - totalPurchase);
  }

  //수익률 계산 = (평가손익 / 매입총액) * 100
  double calculateYield({String exStockPrice, int average}) {
    double percent;
    int _exStockPrice = sanitizeComma(exStockPrice);
    percent = ((average / _exStockPrice) - 1) * 100;
    print(percent);

    return percent - percent % 0.01;
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

//평단가 계산
// int calculateAverage(
//     {String exSCount, String exSPrice, String newSCount, String newSPrice}) {
//   int _exSCount = sanitizeComma(exSCount);
//   int _exSPrice = sanitizeComma(exSPrice);
//   int _newSCount = sanitizeComma(newSCount);
//   int _newSPrice = sanitizeComma(newSPrice);
//   var result = ((_exSCount * _exSPrice) + (_newSCount * _newSPrice)) /
//       (_exSCount + _newSCount);

//   String splitedNumber = result.toString().split('.')[0];
//   int parsedNumber = int.parse(splitedNumber);

//   return parsedNumber;
// }
