import 'package:flutter/cupertino.dart';

//data class
class StockCard {
  StockCard(
      {this.primaryColor,
      this.emoji,
      this.title,
      this.totalValuationPrice,
      this.holdingQuantity,
      this.purchasePrice,
      this.currentStockPrice,
      this.buyPrice,
      this.buyQuantity,
      this.totalValuationResultText,
      this.valuationResultText,
      this.yieldResultText,
      this.yieldDiffText,
      this.purchasePriceResultText,
      this.averagePurchaseDiffText,
      this.isEnd = false});

  // 색, 이모지
  Color primaryColor;
  String emoji;

  //타이틀
  String title;

  // Row1 - 평가금액, 총 보유수량[주]
  int totalValuationPrice;
  int holdingQuantity;
  // Row 2 - 매입 단가(현재 평단가), 현재 주가
  int purchasePrice;
  int currentStockPrice;
  //Row3 - 구매할 주식의 예상가격, 구매할 예상수량[주]
  int buyPrice;
  int buyQuantity;

  // //중간계산용 - 기존 매입총액, 기존 평가 손익, 기존 수익률, 기존 평단가
  // int exTotalPurchase;
  // int exValuationLoss;
  // double exYield;
  // int exAveragePurchase;

  // //구매 이후 계산 결과들 - (계산된) 매입총액, 평단가, 수익률, (이전수익률+계산수익률) 평가금액, 평가손익
  // int calculatedTotalPurchase;
  // int calculatedAveragePurchase;
  // double calculatedYield;
  // int calculatedTotalValuation;
  // int calculatedValuationLoss;

  //                          계산 결과 텍스트들
  //계산된 평가총액, 계산된 평가손익
  String totalValuationResultText;
  String valuationResultText;

  //계산된수익률, 수익률 차이
  String yieldResultText;
  String yieldDiffText;
  // double yieldDiff;

  //계산된 평단가, 평단가 차이
  String purchasePriceResultText;
  String averagePurchaseDiffText;
  // int averagePurchaseDiff;

  bool isEnd;
}
