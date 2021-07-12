import 'dart:convert';

import 'package:flutter/cupertino.dart';

//data class
class StockCard {
  StockCard(
      {this.primaryColor,
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
      this.valuationLossDiffText,
      this.tax,
      this.tradingFee,
      this.currency,
      this.exchangeRate,
      this.isEnd = false});

  // 색, 이모지
  Color primaryColor;

  //타이틀
  String title;

  // Row1 - 평가금액, 총 보유수량[주]
  var totalValuationPrice;
  var holdingQuantity;
  // Row 2 - 매입 단가(현재 평단가), 현재 주가
  var purchasePrice;
  var currentStockPrice;
  //Row3 - 구매할 주식의 예상가격, 구매할 예상수량[주]
  var buyPrice;
  var buyQuantity;

  //세금, 매매수수료
  var tax; //0.015 %
  var tradingFee; // 0.25 %

  //현재 통화, 환율
  String currency;
  double exchangeRate = 1130;

  //                          계산 결과 텍스트들
  //계산된 평가총액, 계산된 평가손익
  String totalValuationResultText;
  String valuationResultText;

  //평가손익 차이
  String valuationLossDiffText;

  //계산된수익률, 수익률 차이
  String yieldResultText;
  String yieldDiffText;

  //계산된 평단가, 평단가 차이
  String purchasePriceResultText;
  String averagePurchaseDiffText;

  bool isEnd;

  factory StockCard.fromJson(Map<String, dynamic> jsonData) {
    //Color 객체가 json에서 지원하지 않아서 하드코딩
    //TODO: 리팩토링 해봅시다 나중에

    if (!jsonData['isEnd']) {
      String colorString = jsonData['primaryColor'];
      Color newColor;

      try {
        String valueString = colorString
            .toString()
            .substring(8, colorString.length - 1); // kind of hacky..
        print(valueString);
        int value = int.parse(valueString, radix: 16);
        newColor = Color(value);
      } catch (e) {
        //마지막 인덱스가 exception에 걸리게된다.
        print(e);
      }

      return StockCard(
        primaryColor: newColor,
        title: jsonData['title'],
        totalValuationPrice: jsonData['totalValuationPrice'],
        holdingQuantity: jsonData['holdingQuantity'],
        purchasePrice: jsonData['purchasePrice'],
        currentStockPrice: jsonData['currentStockPrice'],
        buyPrice: jsonData['buyPrice'],
        buyQuantity: jsonData['buyQuantity'],
        totalValuationResultText: jsonData['totalValuationResultText'],
        valuationResultText: jsonData['valuationResultText'],
        yieldResultText: jsonData['yieldResultText'],
        yieldDiffText: jsonData['yieldDiffText'],
        purchasePriceResultText: jsonData['purchasePriceResultText'],
        averagePurchaseDiffText: jsonData['averagePurchaseDiffText'],
        valuationLossDiffText: jsonData['valuationLossDiffText'],
        tax: jsonData['tax'],
        tradingFee: jsonData['tradingFee'],
        currency: jsonData['currency'],
        exchangeRate: jsonData['exchangeRate'],
        isEnd: false,
      );
    } else {
      return StockCard(isEnd: true);
    }
  }

  static Map<String, dynamic> toMap(StockCard stockCard) => {
        'primaryColor': stockCard.primaryColor.toString(),
        'title': stockCard.title,
        'totalValuationPrice': stockCard.totalValuationPrice,
        'holdingQuantity': stockCard.holdingQuantity,
        'purchasePrice': stockCard.purchasePrice,
        'currentStockPrice': stockCard.currentStockPrice,
        'buyPrice': stockCard.buyPrice,
        'buyQuantity': stockCard.buyQuantity,
        'totalValuationResultText': stockCard.totalValuationResultText,
        'valuationResultText': stockCard.valuationResultText,
        'yieldResultText': stockCard.yieldResultText,
        'yieldDiffText': stockCard.yieldDiffText,
        'purchasePriceResultText': stockCard.purchasePriceResultText,
        'averagePurchaseDiffText': stockCard.averagePurchaseDiffText,
        'valuationLossDiffText': stockCard.valuationLossDiffText,
        'tax': stockCard.tax,
        'tradingFee': stockCard.tradingFee,
        'currency': stockCard.currency,
        'exchangeRate': stockCard.exchangeRate,
        'isEnd': stockCard.isEnd,
      };

  static String encode(List<StockCard> stockCardList) => json.encode(
        stockCardList.map<Map<String, dynamic>>((cardData) {
          return StockCard.toMap(cardData);
        }).toList(),
      );

  static List<StockCard> decode(String stockCardLists) =>
      (json.decode(stockCardLists) as List<dynamic>)
          .map<StockCard>((item) => StockCard.fromJson(item))
          .toList();
}
