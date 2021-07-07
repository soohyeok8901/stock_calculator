import 'package:averge_price_calc/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcBrain extends ChangeNotifier {
  Color setColor({double yieldResult}) {
    if ((yieldResult < 0)) {
      return Colors.blue[800];
    } else if ((yieldResult > 0)) {
      return Colors.red[400];
    } else {
      return grey;
    }
  }

  String setEmoji({double yieldResult}) {
    if ((yieldResult < -30)) {
      return '😭';
    } else if ((yieldResult >= -30 && yieldResult < -10)) {
      return '😟';
    } else if ((yieldResult >= -10 && yieldResult < 0)) {
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

  //////////////////////물타기 계산기 파트
  //기존 매입총액 계산 = 평가총액 - 매입총액
  int calculateExTotalPurchase({int purchasePrice, int holdingQuantity}) {
    return purchasePrice * holdingQuantity;
  }

  //기존 평가손익 계산 = 평가총액 - 매입총액
  int calculateExValuationLoss({int totalValuationPrice, int totalPurchase}) {
    return (totalValuationPrice - totalPurchase);
  }

  //기존 수익률 계산 = (기존 평가손익 / 매입총액) * 100
  double calculateExYield({int exValuationLoss, int exTotalPurchase}) {
    double percent;
    try {
      percent = (exValuationLoss / exTotalPurchase) * 100;
      return percent - percent % 0.01;
    } catch (e) {
      return 0;
    }
  }

  //기존 평단가 계산 = 매입총액 / 수량
  int calculateExPurchase({int totalPurchase, int holdingQuantity}) {
    try {
      return (totalPurchase / holdingQuantity).round();
    } catch (e) {
      return 0;
    }
  }

  //계산된 매입총액 = 기존 매입총액 + (구매예상 가격 * 구매수량)
  int calculateNewTotalPurchase(
      {int exTotalPurchase, int buyPrice, int buyQuantity}) {
    return exTotalPurchase + (buyPrice * buyQuantity);
  }

  //게산된 평단가 = 계산된 매입총액 / (기존 수량 + 구매 수량)
  int calculateNewAveragePurchase(
      {int calculatedTotalPurchase, int holdingQuantity, int buyQuantity}) {
    try {
      return (calculatedTotalPurchase / (holdingQuantity + buyQuantity))
          .round();
    } catch (e) {
      return 0;
    }
  }

  //계산된 평가금액 = 구매가 * (기존 수량 + 구매 수량)
  int calculateNewTotalValuation(
      {int buyPrice, int holdingQuantity, int buyQuantity}) {
    return (buyPrice * (holdingQuantity + buyQuantity));
  }

  //계산된 평가손익 = 계산된 평가금액 - 계산된 매입금액
  int calculateNewValuationLoss(
      {int calculatedTotalValuation, int calculatedTotalPurchase}) {
    return calculatedTotalValuation - calculatedTotalPurchase;
  }

  //계산된 수익률 = (계산된 평가손익 / 계산된 매입총액) * 100
  double calculateNewYield(
      {int calculatedValuationLoss, int calculatedTotalPurchase}) {
    double percent;
    try {
      percent = (calculatedValuationLoss / calculatedTotalPurchase) * 100;
      return percent - percent % 0.01;
    } catch (e) {
      return 0;
    }
  }

  //평단가 차이 계산 = 계산된 평단가 - 기존 평단가
  int calculateAveragePurchaseDiff(
      {int calculatedAveragePurchase, int exAveragePurchase}) {
    return calculatedAveragePurchase - exAveragePurchase;
  }

  //수익률 차이 계산 = 계산된 수익률 - 기존 수익률
  double calculateYieldDiff({double calculatedYield, double exYield}) {
    return calculatedYield - exYield;
  }

  //평가손익 차이계산 = 계산된 평가손익 - 기존 평가손익
  int calculateValuationLoss({int exValuationLoss, int newValuationLoss}) {
    return newValuationLoss - exValuationLoss;
  }

  //컴마, 온점 거르기 함수
  //TODO: TextField 에서 input 조건 달아서 필요없어짐 나중에 리팩토링
  int sanitizeComma(String input) {
    List splitedInput;
    if (input.length == 0) {
      return null;
    }

    if (input.contains(',')) {
      splitedInput = input.split(',');
      String joinedInput = splitedInput.join("");
      return int.parse(joinedInput);
    } else if (input.contains('.')) {
      splitedInput = input.split('.');
      String joinedInput = splitedInput.join("");
      return int.parse(joinedInput);
    } else if (input.contains('-')) {
      splitedInput = input.split('-');
      String joinedInput = splitedInput.join("");
      return int.parse(joinedInput);
    } else {
      return int.parse(input);
    }
  }
}
