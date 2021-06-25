import 'package:averge_price_calc/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcBrain extends ChangeNotifier {
  Color setColor({double yieldResult}) {
    if ((yieldResult < 0)) {
      return Colors.blue[400];
    } else if ((yieldResult > 0)) {
      return Colors.red[400];
    } else {
      return grey;
    }
  }

  String setEmoji({double yieldResult}) {
    if ((yieldResult < -40)) {
      return '😭';
    } else if ((yieldResult >= -40 && yieldResult < -20)) {
      return '😟';
    } else if ((yieldResult >= -20 && yieldResult < 0)) {
      return '🤨';
    } else if ((yieldResult >= 0 && yieldResult < 8)) {
      return '🙂';
    } else if ((yieldResult >= 8 && yieldResult < 17)) {
      return '😊';
    } else if ((yieldResult >= 17 && yieldResult < 30)) {
      return '🥰';
    } else {
      return '🥳';
    }
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
  double calculateYield({int valuation, int totalPurchase}) {
    double percent;
    percent = (valuation / totalPurchase) * 100;
    print(percent);
    return percent - percent % 0.01;
  }

  //평단가 계산 = 매입총액 / 수량
  int calculatePurchasePrice({int totalPurchase, String holdingQuantity}) {
    return (totalPurchase / sanitizeComma(holdingQuantity)).round();
  }

  //컴마, 온점 거르기 함수
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
