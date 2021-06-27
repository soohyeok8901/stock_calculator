import 'package:averge_price_calc/models/calculator.dart';
// import 'package:averge_price_calc/models/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class HandleUiDataProvider extends ChangeNotifier {
  /// fields

  //color, emoji
  Color primaryColor = grey;
  String emoji = '🙂';

  //타이틀
  String title;

  ///
  ///
  ///
  ///
  //////////////////////계산기 관련 변수
  //Row1 - 총 평가금액, 총 보유수량
  int totalValuationPrice;
  int holdingQuantity;

  //Row2 - 매입 단가(현재 평단가), 현재 주가
  int purchasePrice;
  int currentStockPrice;

  //Row3 - 구매할 주식의 예상가격, 구매할 예상수량[주]
  int buyPrice;
  int buyQuantity;

  //중간계산용 - 기존 매입총액, 기존 평가 손익, 기존 평가총액, 기존 평가손익, 기존 수익률, 기존 평단가
  //////////////////구매 이전 보유 주식의 계산 결과들 (평단가 차이, 수익률 차이를 위한 변수들)
  int exTotalPurchase;
  int exValuationLoss;
  // int exTotalValuationResult;
  // int exValuationLoss;
  double exYield;
  int exAveragePurchase;

  /////////////////구매 이후 계산 결과들 - (계산된) 매입총액, 평단가, 수익률, (이전수익률+계산수익률) 평가금액, 평가손익
  int calculatedTotalPurchase;
  int calculatedAveragePurchase;
  double calculatedYield;
  int calculatedTotalValuation;
  int calculatedValuationLoss;

  //계산 결과 텍스트들 - 계산된 평가총액, 계산된 평가손익, 계산된 수익률, 계산된 평단가
  String totalValuationResultText;
  String valuationResultText;
  String yieldResultText;
  String purchasePriceResultText;
  // - 평단가 차이, 수익률 차이, (계산된 평가손익)
  int averagePurchaseDiff;
  String averagePurchaseDiffText;
  double yieldDiff;
  String yieldDiffText;

  ///

  int nowPageIndex = 0;

  CalcBrain calcBrain = CalcBrain();

  //////////////////////////shared_preferences
  void loadData() async {
    print('loadData()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //생각해보니까 텍스트필드에 저장이 돼있으면 그거 기반으로 계산하는거잖아
    //저장할 필요가 없네?
    //텍스트필드 데이터랑 resultBox 데이터만 저장하면 되는거아니야?
    // //TextField 파트
    // totalValuationPrice = prefs.getInt('totalValuationPrice') ?? 0;
    // holdingQuantity = prefs.getInt('holdingQuantity') ?? 0;
    // purchasePrice = prefs.getInt('purchasePrice') ?? 0;
    // currentStockPrice = prefs.getInt('currentStockPrice') ?? 0;
    // buyPrice = prefs.getInt('buyPrice') ?? 0;
    // buyQuantity = prefs.getInt('buyQuantity') ?? 0;

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
    notifyListeners();
  }

  void saveData() async {
    print('saveData()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //TODO: shared_preferences를 이용해 전부 저장할 것
    //필드 파트

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

  //ui 값들을 List[i] 값으로 전부 수정 (페이지슬라이드시 동작)
  void setData() {
    notifyListeners();
  }

  //TextField null 체크
  bool validate(String text) {
    if (text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //계산 버튼을 눌렀을 때, result text, diff text, percent text 갱신
  void tabCalculateButton(BuildContext _) {
    print('tabCalcuateButton 함수 실행');

    //TODO: 계산 버튼 눌렀을 때 모든 텍스트필드들 값 저장되도록 하는 메서드 필요
    //TODO: 왜냐하면 shared_preferences에서 값 로딩했을 때 저장이 안됑ㅆ기 때문 아그냥 다 저장하면 되잖아? ㅇㅋ
    //TODO: sharedPreferences에서 중간 값 전부 다 저장해둘것 ㅇㅇ

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

    //////////////////////텍스트화
    totalValuationResultText =
        '${currencyFormat(calcBrain.sanitizeComma(calculatedTotalValuation.toString()))} 원';
    valuationResultText =
        addSuffixWonWithBrackets(currencyFormat(calculatedValuationLoss));
    yieldResultText = addSuffixPercent(calculatedYield);
    purchasePriceResultText =
        addSuffixWon(currencyFormat(calculatedAveragePurchase));

    // 수익률 차이, 평단가 차이 음수 양수 판단용 메서드
    determineNegativeForYield();
    determineNegativeForAveragePurchase();

    ///////////////////////ui용 색, 이모지
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

  String currencyFormat(int price) {
    final formatCurrency = new NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return formatCurrency.format(price);
    // notifyListeners();
  }

  ///////////////필드각각 대응되는 changeString 메서드
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

  String addSuffixWonWithBrackets(String value) {
    return '($value 원)';
  }

  String addSuffixPercent(double value) {
    return '${value.toStringAsFixed(2)} %';
  }

  String addSuffixWon(String value) {
    return '$value 원';
  }

  ///////////////////// title Widget 관련 ///////////////////
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
}
