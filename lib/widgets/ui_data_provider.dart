import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class HandleUiDataProvider extends ChangeNotifier {
  //캐러샐용 DataClass List
  List<StockCard> stockCardList = [
    StockCard(
      primaryColor: grey,
      emoji: '🙂',
      title: '계산기 1',
      totalValuationPrice: null,
      holdingQuantity: null,
      purchasePrice: null,
      currentStockPrice: null,
      buyPrice: null,
      buyQuantity: null,
      totalValuationResultText: '0 원',
      valuationResultText: null,
      yieldResultText: '0 %',
      yieldDiffText: null,
      purchasePriceResultText: '0 원',
      averagePurchaseDiffText: null,
    ),
    StockCard(
      isEnd: true,
    ),
  ];

  //color, emoji
  Color primaryColor = grey;
  String emoji = '🙂';

  //타이틀
  String title;

  ///
  ///
  ///                           계산기 관련 변수
  ///
  ///
  //Row1 - 총 평가금액, 총 보유수량
  int totalValuationPrice;
  int holdingQuantity;

  //Row2 - 매입 단가(현재 평단가), 현재 주가
  int purchasePrice;
  int currentStockPrice;

  //Row3 - 구매할 주식의 예상가격, 구매할 예상수량[주]
  int buyPrice;
  int buyQuantity;

  //중간계산용 - 기존 매입총액, 기존 평가 손익, 기존 수익률, 기존 평단가
  //            구매 이전 보유 주식의 계산 결과들 (평단가 차이, 수익률 차이를 위한 변수들)
  int exTotalPurchase;
  int exValuationLoss;
  double exYield;
  int exAveragePurchase;

  //구매 이후 계산 결과들 - (계산된) 매입총액, 평단가, 수익률, (이전수익률+계산수익률) 평가금액, 평가손익
  int calculatedTotalPurchase;
  int calculatedAveragePurchase;
  double calculatedYield;
  int calculatedTotalValuation;
  int calculatedValuationLoss;

  //                          계산 결과 텍스트들
  //계산된 평가총액, 계산된 평가손익
  String totalValuationResultText;
  String valuationResultText;
  //계산된수익률, 수익률 차이
  String yieldResultText;
  double yieldDiff;
  String yieldDiffText;
  //계산된 평단가, 평단가 차이
  String purchasePriceResultText;
  int averagePurchaseDiff;
  String averagePurchaseDiffText;

  int nowPageIndex = 0;

  CalcBrain calcBrain = CalcBrain();

  ///
  ///                 shared_preferences methods
  ///
  ///
  void loadData() async {
    print('loadData()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // //TextField 파트
    totalValuationPrice = prefs.getInt('totalValuationPrice') ?? 0;
    holdingQuantity = prefs.getInt('holdingQuantity') ?? 0;
    purchasePrice = prefs.getInt('purchasePrice') ?? 0;
    currentStockPrice = prefs.getInt('currentStockPrice') ?? 0;
    buyPrice = prefs.getInt('buyPrice') ?? 0;
    buyQuantity = prefs.getInt('buyQuantity') ?? 0;

    // //중간계산 파트
    // exTotalPurchase = prefs.getInt('exTotalPurchase') ?? 0;

    //결과값 파트
    //근데 결과값도 만약 없으면 0원으로 표기되게 해뒀으니까 저장할 필요없음
    totalValuationResultText = prefs.getString('totalValuationResultText');
    valuationResultText = prefs.getString('valuationResultText');
    yieldResultText = prefs.getString('yieldResultText');
    purchasePriceResultText = prefs.getString('purchasePriceResultText');
    averagePurchaseDiffText = prefs.getString('averagePurchaseDiffText');
    yieldDiffText = prefs.getString('yieldDiffText');
    emoji = prefs.getString('emoji');
    calculatedYield = prefs.getDouble('calculatedYield');

    //색깔 결정
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);

    notifyListeners();
  }

  void saveData() async {
    print('saveData()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //필드 파트
    prefs.setInt('totalValuationPrice', totalValuationPrice);
    prefs.setInt('holdingQuantity', holdingQuantity);
    prefs.setInt('purchasePrice', purchasePrice);
    prefs.setInt('currentStockPrice', currentStockPrice);
    prefs.setInt('buyPrice', buyPrice);
    prefs.setInt('buyQuantity', buyQuantity);

    //중간 계산 파트

    //결과값(number)파트

    //result text(String) 파트
    prefs.setString('totalValuationResultText', totalValuationResultText);
    prefs.setString('valuationResultText', valuationResultText);
    prefs.setString('yieldResultText', yieldResultText);
    prefs.setString('purchasePriceResultText', purchasePriceResultText);
    prefs.setString('averagePurchaseDiffText', averagePurchaseDiffText);
    prefs.setString('yieldDiffText', yieldDiffText);
    prefs.setString('emoji', emoji);
    prefs.setDouble('calculatedYield', calculatedYield);
  }

  void saveDataForClear() async {
    print('saveDataForClear()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //필드 파트
    prefs.setInt('totalValuationPrice', 0);
    prefs.setInt('holdingQuantity', 0);
    prefs.setInt('purchasePrice', 0);
    prefs.setInt('currentStockPrice', 0);
    prefs.setInt('buyPrice', 0);
    prefs.setInt('buyQuantity', 0);

    //중간 계산 파트

    //결과값(number)파트

    //result text(String) 파트
    prefs.setString('totalValuationResultText', totalValuationResultText);
    prefs.setString('valuationResultText', valuationResultText);
    prefs.setString('yieldResultText', yieldResultText);
    prefs.setString('purchasePriceResultText', purchasePriceResultText);
    prefs.setString('averagePurchaseDiffText', averagePurchaseDiffText);
    prefs.setString('yieldDiffText', yieldDiffText);
    prefs.setString('emoji', emoji);
    prefs.setDouble('calculatedYield', 0);
  }

  ///
  ///                  UI, 계산기 관련 methods
  ///
  ///
  //계산 버튼을 눌렀을 때, result text, diff text, percent text 갱신
  void tabCalculateButton(BuildContext _) {
    print('tabCalcuateButton 함수 실행');

    //기존 매입총액 중간계산 <int>
    exTotalPurchase = calcBrain.calculateExTotalPurchase(
      purchasePrice: purchasePrice,
      holdingQuantity: holdingQuantity,
    );

    //기존 평가손익 중간계산 <int>
    exValuationLoss = calcBrain.calculateExValuationLoss(
      totalValuationPrice: totalValuationPrice,
      totalPurchase: exTotalPurchase,
    );

    //기존 수익률 계산
    exYield = calcBrain.calculateExYield(
      exValuationLoss: exValuationLoss,
      exTotalPurchase: exTotalPurchase,
    );

    //기존 평단가 계산
    exAveragePurchase = calcBrain.calculateExPurchase(
      totalPurchase: exTotalPurchase,
      holdingQuantity: holdingQuantity,
    );

    // 새로운 매입총액 계산
    calculatedTotalPurchase = calcBrain.calculateNewTotalPurchase(
        exTotalPurchase: exTotalPurchase,
        buyPrice: buyPrice,
        buyQuantity: buyQuantity);

    // 새로운 평단가 계산
    calculatedAveragePurchase = calcBrain.calculateNewAveragePurchase(
        calculatedTotalPurchase: calculatedTotalPurchase,
        holdingQuantity: holdingQuantity,
        buyQuantity: buyQuantity);

    // 새로운 평가금액 계산
    calculatedTotalValuation = calcBrain.calculateNewTotalValuation(
        buyPrice: buyPrice,
        holdingQuantity: holdingQuantity,
        buyQuantity: buyQuantity);

    // 새로운 평가손익 계산
    calculatedValuationLoss = calcBrain.calculateNewValuationLoss(
        calculatedTotalPurchase: calculatedTotalPurchase,
        calculatedTotalValuation: calculatedTotalValuation);

    // 새로운 수익률 계산
    calculatedYield = calcBrain.calculateNewYield(
        calculatedTotalPurchase: calculatedTotalPurchase,
        calculatedValuationLoss: calculatedValuationLoss);

    // 평단가 차이 계산
    averagePurchaseDiff = calcBrain.calculateAveragePurchaseDiff(
        calculatedAveragePurchase: calculatedAveragePurchase,
        exAveragePurchase: exAveragePurchase);

    // 수익률 차이 계산
    yieldDiff = calcBrain.calculateYieldDiff(
        calculatedYield: calculatedYield, exYield: exYield);

    //텍스트화
    totalValuationResultText =
        '${currencyFormat(calcBrain.sanitizeComma(calculatedTotalValuation.toString()))} 원';
    valuationResultText =
        addSuffixWonWithBrackets(currencyFormat(calculatedValuationLoss));
    yieldResultText = addSuffixPercent(calculatedYield);
    purchasePriceResultText =
        addSuffixWon(currencyFormat(calculatedAveragePurchase));

    //수익률 차이, 평단가 차이 음수 양수 판단용 메서드
    determineNegativeForYield();
    determineNegativeForAveragePurchase();

    //ui용 색, 이모지
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);
    emoji = calcBrain.setEmoji(yieldResult: calculatedYield);

    notifyListeners();
    //키보드 끄기
    FocusScope.of(_).unfocus();
  }

  //초기화 버튼을 눌렀을 때 result text, diff text, percent text 초기화
  void tabClearButton(BuildContext _) {
    print('tabClearButton 함수 실행');
    //키보드 끄기
    FocusScope.of(_).unfocus();

    totalValuationResultText = '0 원';
    valuationResultText = '';
    yieldResultText = '0 %';
    purchasePriceResultText = '0 원';

    yieldDiffText = '';
    averagePurchaseDiffText = '';

    primaryColor = grey;
    emoji = '🙂';

    notifyListeners();
  }

  //통화단위(원) 붙이기
  String currencyFormat(int price) {
    final formatCurrency = new NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return formatCurrency.format(price);
  }

  //                     필드각각 대응되는 changeString 메서드
  void changeTitleData(String newData) {
    title = newData;

    notifyListeners();
  }

  void changeTotalValuationPriceData(String newData) {
    totalValuationPrice = calcBrain.sanitizeComma(newData);
    notifyListeners();
  }

  void changeHoldingQuantityData(String newData) {
    holdingQuantity = calcBrain.sanitizeComma(newData);
    notifyListeners();
  }

  void changePurchasePriceData(String newData) {
    purchasePrice = calcBrain.sanitizeComma(newData);
    notifyListeners();
  }

  void changeCurrentStockPriceData(String newData) {
    currentStockPrice = calcBrain.sanitizeComma(newData);
    notifyListeners();
  }

  void changeBuyPriceData(String newData) {
    buyPrice = calcBrain.sanitizeComma(newData);
    notifyListeners();
  }

  void changeBuyQuantityData(String newData) {
    buyQuantity = calcBrain.sanitizeComma(newData);
    notifyListeners();
  }

  //계산결과의 차이값에 방향화살표 붙이기
  void determineNegativeForYield() {
    if (yieldDiff < 0) {
      yieldDiffText = '${yieldDiff.toStringAsFixed(2)} %⬇';
    } else {
      yieldDiffText = '${yieldDiff.toStringAsFixed(2)} %⬆';
    }
  }

  void determineNegativeForAveragePurchase() {
    String data;
    if (averagePurchaseDiff < 0) {
      data = currencyFormat(averagePurchaseDiff);
      averagePurchaseDiffText = '$data⬇';
    } else {
      data = currencyFormat(averagePurchaseDiff);
      averagePurchaseDiffText = '$data⬆';
    }
  }

  //원, 괄호 붙이기
  String addSuffixWonWithBrackets(String value) {
    return '($value 원)';
  }

  String addSuffixPercent(double value) {
    return '${value.toStringAsFixed(2)} %';
  }

  String addSuffixWon(String value) {
    return '$value 원';
  }

  ///
  ///                     title Widget 관련
  ///
  ///
  bool modifyMode = true;

  bool toggleModifyMode(bool mode) {
    ChangeNotifier();
    print(modifyMode);
    if (mode) {
      return false;
    } else {
      return true;
    }
  }

  ///
  ///                   Carousel Card 관련 methods
  ///
  //TODO: 여기서부터 하면 되겠죠?
  //ui 값들을 List[i] 값으로 전부 수정 (페이지슬라이드시 동작)
  void setData() {
    notifyListeners();
  }
}
