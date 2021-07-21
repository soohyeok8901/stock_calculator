import 'dart:developer';

import 'package:stock_calculator/utils/calculator.dart';
import 'package:stock_calculator/models/stock_card.dart';
import 'package:stock_calculator/utils/string_func.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class UiDataProvider extends ChangeNotifier {
  //캐러샐용 DataClass List
  List<StockCard> stockCardList = [
    StockCard(
      primaryColor: grey,
      // emoji: '🙂',
      title: '계산기 1',
      totalValuationPrice: 0, //평가금액
      holdingQuantity: 0, //보유개수
      purchasePrice: 0, // 현재평단가
      currentStockPrice: 0, //현재 주가
      buyPrice: 0, //구매가격
      buyQuantity: 0, //구매수량
      totalValuationResultText: '0 원', //평가금액 텍스트
      valuationResultText: '0 원', //평가손익 텍스트
      valuationLossDiffText: '', //평가금액 - 평가손익 텍스트
      yieldResultText: '0.00 %', //수익률 텍스트
      yieldDiffText: '', // 계산수익률 - 기존수익률 텍스트
      purchasePriceResultText: '0 원', //계산된 평단가
      averagePurchaseDiffText: '', //계산평단가 - 기존평단가 텍스트
      tax: 0.015,
      tradingFee: 0.25,
      currency: '원',
      exchangeRate: 1130,
    ),
    StockCard(
      primaryColor: null,
      // emoji: null,
      title: null,
      totalValuationPrice: null,
      holdingQuantity: null,
      purchasePrice: null,
      currentStockPrice: null,
      buyPrice: null,
      buyQuantity: null,
      totalValuationResultText: null,
      valuationResultText: null,
      yieldResultText: null,
      yieldDiffText: null,
      purchasePriceResultText: null,
      averagePurchaseDiffText: null,
      tax: null,
      tradingFee: null,
      currency: null,
      exchangeRate: null,
      isEnd: true,
    ),
  ];

  //color, emoji
  Color primaryColor = grey;
  // String emoji = '🙂';

  //타이틀
  String title;

  ///
  ///
  ///                           계산기 관련 변수
  ///
  ///
  //Row1 - 현재 평가금액, 현재 보유수량
  var totalValuationPrice;
  var holdingQuantity;

  //Row2 - 매입 단가(현재 평단가), 현재 주가
  var purchasePrice;
  var currentStockPrice;

  //Row3 - 구매할 주식의 예상가격, 구매할 예상수량[주]
  var buyPrice;
  var buyQuantity;

  //중간계산용 - 기존 매입총액, 기존 평가 손익, 기존 수익률, 기존 평단가
  //            구매 이전 보유 주식의 계산 결과들 (평단가 차이, 수익률 차이를 위한 변수들)
  var exTotalPurchase;
  var exValuationLoss;
  double exYield;
  var exAveragePurchase;

  //구매 이후 계산 결과들 - (계산된) 매입총액, 평단가, 수익률, (이전수익률+계산수익률) 평가금액, 평가손익
  int calculatedTotalPurchase = 0;
  int calculatedAveragePurchase = 0;
  double calculatedYield = 0;
  int calculatedTotalValuation = 0;
  int calculatedValuationLoss = 0;

  //                          계산 결과 텍스트들
  //계산된 평가총액, 계산된 평가손익
  String totalValuationResultText;
  String valuationResultText;
  //평가손익 차이
  int valuationLossDiff;
  String valuationLossDiffText;
  //계산된수익률, 수익률 차이
  String yieldResultText;
  double yieldDiff;
  String yieldDiffText;
  //계산된 평단가, 평단가 차이
  String purchasePriceResultText;
  int averagePurchaseDiff;
  String averagePurchaseDiffText;

  int nowPageIndex = 0;
  bool _isLastPage = false; // main_screen 에서 main Container 조건부 렌더링하는데에 사용됩니다.

  bool isEnd;

  ///세금, 매매수수료, 통화, 환율
  double tax;
  double tradingFee;
  String currency;
  var exchangeRate;

  CalcBrain calcBrain = CalcBrain();

  ///                 shared_preferences methods
  ///
  ///
  void loadData() async {
    print('loadData()');
    // clearList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //TextField 파트
    totalValuationPrice = prefs.getInt('totalValuationPrice') ?? 0;
    holdingQuantity = prefs.getInt('holdingQuantity') ?? 0;
    purchasePrice = prefs.getInt('purchasePrice') ?? 0;
    currentStockPrice = prefs.getInt('currentStockPrice') ?? 0;
    tax = prefs.getDouble('tax') ?? 0.25;
    tradingFee = prefs.getDouble('tradingFee') ?? 0.015;
    // buyPrice = prefs.getInt('buyPrice') ?? 0;
    // buyQuantity = prefs.getInt('buyQuantity') ?? 0;

    //중간계산 파트
    // exTotalPurchase = prefs.getInt('exTotalPurchase') ?? 0;

    //결과값 파트
    //근데 결과값도 만약 없으면 0원으로 표기되게 해뒀으니까 저장할 필요없음
    totalValuationResultText =
        prefs.getString('totalValuationResultText') ?? '0 원';
    valuationResultText = prefs.getString('valuationResultText') ?? '0 원';
    yieldResultText = prefs.getString('yieldResultText') ?? '0.00 %';
    purchasePriceResultText =
        prefs.getString('purchasePriceResultText') ?? '0 원';
    valuationLossDiffText = prefs.getString('valuationLossDiffText') ?? '';
    averagePurchaseDiffText = prefs.getString('averagePurchaseDiffText') ?? '';
    yieldDiffText = prefs.getString('yieldDiffText') ?? '';
    // emoji = prefs.getString('emoji') ?? '🙂';
    calculatedYield = prefs.getDouble('calculatedYield') ?? 0;

    //색깔 결정
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);

    //stockCardList 파트
    var encodedListData = prefs.getString('stockCardList');
    if (encodedListData != null) {
      stockCardList = StockCard.decode(encodedListData);
    }

    nowPageIndex = prefs.getInt('nowPageIndex') ?? 0;

    notifyListeners();
  }

  void saveTotalValuationPriceData() async {
    print('save totalValuationPrice 평가금액');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (totalValuationPrice != null) {
      prefs.setInt('totalValuationPrice', totalValuationPrice);
    }
  }

  void saveHoldingQuantityData() async {
    print('save holdingQunatity 보유개수');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (holdingQuantity != null) {
      prefs.setInt('holdingQuantity', holdingQuantity);
    }
  }

  void savePurchasePriceData() async {
    print('save purchasePrice 보유개수');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (purchasePrice != null) {
      prefs.setInt('purchasePrice', purchasePrice);
    }
  }

  void saveCurrentStockPriceData() async {
    print('save currentStockPrice 현재주가');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentStockPrice != null) {
      prefs.setInt('currentStockPrice', currentStockPrice);
    }
  }

  void saveTaxData() async {
    print('save tax 세금');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tax != null) {
      prefs.setDouble('tax', tax);
    }
  }

  void saveTradingFeeData() async {
    print('save tradingFee 세금');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tradingFee != null) {
      prefs.setDouble('tradingFee', tradingFee);
    }
  }

  void saveData() async {
    print('saveData()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //중간 계산 파트

    //결과값(number)파트

    //result text(String) 파트
    prefs.setString('totalValuationResultText', totalValuationResultText);
    prefs.setString('valuationResultText', valuationResultText);
    prefs.setString('yieldResultText', yieldResultText);
    prefs.setString('purchasePriceResultText', purchasePriceResultText);
    prefs.setString('valuationLossDiffText', valuationLossDiffText);
    prefs.setString('averagePurchaseDiffText', averagePurchaseDiffText);
    prefs.setString('yieldDiffText', yieldDiffText);
    // prefs.setString('emoji', emoji);
    prefs.setDouble('calculatedYield', calculatedYield);

    //stockCardList 파트
    //1. list 직렬화
    var encodedListData = StockCard.encode(stockCardList);
    //2. 직렬화한 list를 setString으로 저장
    prefs.setString('stockCardList', encodedListData);

    //nowPageIndex 저장
    prefs.setInt('nowPageIndex', nowPageIndex);
  }

  void saveDataForClear() async {
    print('saveDataForClear()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //필드 파트
    prefs.setInt('totalValuationPrice', 0);
    prefs.setInt('holdingQuantity', 0);
    prefs.setInt('purchasePrice', 0);
    prefs.setInt('currentStockPrice', 0);
    prefs.setDouble('tax', 0.00);
    prefs.setDouble('tradingFee', 0.00);

    //중간 계산 파트

    //결과값(number)파트

    //result text(String) 파트
    prefs.setString('totalValuationResultText', totalValuationResultText);
    prefs.setString('valuationResultText', valuationResultText);
    prefs.setString('yieldResultText', yieldResultText);
    prefs.setString('purchasePriceResultText', purchasePriceResultText);
    prefs.setString('valuationLossDiffText', valuationLossDiffText);
    prefs.setString('averagePurchaseDiffText', averagePurchaseDiffText);
    prefs.setString('yieldDiffText', yieldDiffText);
    // prefs.setString('emoji', emoji);
    prefs.setDouble('calculatedYield', 0);
  }

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
    if (calcBrain
        .calculateNewYield(
            calculatedTotalPurchase: calculatedTotalPurchase,
            calculatedValuationLoss: calculatedValuationLoss)
        .isNaN) {
      calculatedYield = 0;
    } else {
      calculatedYield = calcBrain.calculateNewYield(
          calculatedTotalPurchase: calculatedTotalPurchase,
          calculatedValuationLoss: calculatedValuationLoss);
    }

    // 평가손익 차이 계산
    valuationLossDiff = calcBrain.calculateValuationLoss(
        exValuationLoss: exValuationLoss,
        newValuationLoss: calculatedValuationLoss);

    // 평단가 차이 계산
    averagePurchaseDiff = calcBrain.calculateAveragePurchaseDiff(
        calculatedAveragePurchase: calculatedAveragePurchase,
        exAveragePurchase: exAveragePurchase);

    // 수익률 차이 계산
    if (calcBrain
        .calculateYieldDiff(calculatedYield: calculatedYield, exYield: exYield)
        .isNaN) {
      yieldDiff = 0;
    } else {
      yieldDiff = calcBrain.calculateYieldDiff(
          calculatedYield: calculatedYield, exYield: exYield);
    }

    //텍스트화
    totalValuationResultText =
        '${currencyFormat(calcBrain.sanitizeComma(calculatedTotalValuation.toString()))} 원';
    if (calculatedValuationLoss > 0) {
      valuationResultText =
          '+${addSuffixWon(currencyFormat(calculatedValuationLoss))}';
    } else {
      valuationResultText =
          addSuffixWon(currencyFormat(calculatedValuationLoss));
    }

    yieldResultText = addSuffixPercent(calculatedYield);

    purchasePriceResultText =
        addSuffixWon(currencyFormat(calculatedAveragePurchase));

    //수익률 차이, 평단가 차이 음수 양수 판단용 메서드
    determineNegativeForValuationLossDiff();
    determineNegativeForYield();
    determineNegativeForAveragePurchase();

    //ui용 색, 이모지
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);
    // emoji = calcBrain.setEmoji(yieldResult: calculatedYield);

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
    yieldResultText = '0.00 %';
    purchasePriceResultText = '0 원';
    valuationResultText = '0 원';

    yieldDiffText = '';
    averagePurchaseDiffText = '';

    primaryColor = grey;
    // emoji = '🙂';

    notifyListeners();
  }

  //                     필드각각 대응되는 changeString 메서드
  void changeTitleData(String newData) {
    title = newData;
    saveData();
    notifyListeners();
  }

  void changeTotalValuationPriceData(String newData) {
    totalValuationPrice = calcBrain.sanitizeComma(newData);
    saveTotalValuationPriceData();
    notifyListeners();
  }

  void changeHoldingQuantityData(String newData) {
    holdingQuantity = calcBrain.sanitizeComma(newData);
    saveHoldingQuantityData();
    notifyListeners();
  }

  void changePurchasePriceData(String newData) {
    purchasePrice = calcBrain.sanitizeComma(newData);
    savePurchasePriceData();
    notifyListeners();
  }

  void changeCurrentStockPriceData(String newData) {
    currentStockPrice = calcBrain.sanitizeComma(newData);
    saveCurrentStockPriceData();
    notifyListeners();
  }

  void changeTaxData(String newData) {
    tax = double.parse(calcBrain.sanitizeComma(newData).toString());
    saveTaxData();
    notifyListeners();
  }

  void changeTradingFeeData(String newData) {
    tradingFee = double.parse(calcBrain.sanitizeComma(newData).toString());
    saveTradingFeeData();
    notifyListeners();
  }

  //계산결과의 차이값에 방향화살표 붙이기
  void determineNegativeForValuationLossDiff() {
    String data;
    if (valuationLossDiff < 0) {
      data = currencyFormat(valuationLossDiff);
      valuationLossDiffText = '($data 원)';
    } else if (yieldDiff == 0) {
      valuationLossDiffText = '';
    } else {
      data = currencyFormat(valuationLossDiff);
      valuationLossDiffText = '(+$data 원)';
    }
  }

  void determineNegativeForYield() {
    if (yieldDiff < 0) {
      yieldDiffText = '(${yieldDiff.toStringAsFixed(2)} %)';
    } else if (yieldDiff == 0) {
      yieldDiffText = '';
    } else {
      yieldDiffText = '(+${yieldDiff.toStringAsFixed(2)} %)';
    }
  }

  void determineNegativeForAveragePurchase() {
    String data;
    if (averagePurchaseDiff < 0) {
      data = currencyFormat(averagePurchaseDiff);
      averagePurchaseDiffText = '($data 원)';
    } else if (averagePurchaseDiff == 0) {
      data = currencyFormat(averagePurchaseDiff);
      averagePurchaseDiffText = '';
    } else {
      data = currencyFormat(averagePurchaseDiff);
      averagePurchaseDiffText = '(+$data 원)';
    }
  }

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

  ///                   Carousel Card 관련 methods
  ///
  void setData() {
    print('$nowPageIndex 에 저장');
    if (nowPageIndex != stockCardList.length - 1) {
      stockCardList[nowPageIndex].primaryColor = primaryColor;
      // stockCardList[nowPageIndex].emoji = emoji;

      stockCardList[nowPageIndex].totalValuationPrice = totalValuationPrice;
      stockCardList[nowPageIndex].holdingQuantity = holdingQuantity;
      stockCardList[nowPageIndex].purchasePrice = purchasePrice;
      stockCardList[nowPageIndex].currentStockPrice = currentStockPrice;
      stockCardList[nowPageIndex].tax = tax;
      stockCardList[nowPageIndex].tradingFee = tradingFee;
      stockCardList[nowPageIndex].totalValuationResultText =
          totalValuationResultText;
      stockCardList[nowPageIndex].valuationResultText = valuationResultText;
      stockCardList[nowPageIndex].yieldResultText = yieldResultText;
      stockCardList[nowPageIndex].yieldDiffText = yieldDiffText;
      stockCardList[nowPageIndex].purchasePriceResultText =
          purchasePriceResultText;
      stockCardList[nowPageIndex].averagePurchaseDiffText =
          averagePurchaseDiffText;
      stockCardList[nowPageIndex].valuationLossDiffText = valuationLossDiffText;

      notifyListeners();
    } else {
      print('추가 카드입니다. 저장 불가능');
    }
  }

  void setTitle() {
    if (stockCardList[nowPageIndex].title.length > 0) {
      stockCardList[nowPageIndex].title = title;
      saveData();
      notifyListeners();
    } else {
      return;
    }
  }

  //캐러샐 onPageChanged 리스너용 data Load 메서드
  //ui 값들을 List[i] 값으로 전부 수정 (페이지슬라이드시 동작)
  void loadUiByChangedPage({int index}) {
    print('인덱스 $index 마지막인덱스 ${stockCardList.length - 1} ');

    //인덱스에 따른 데이터들을 필드들에 저장하면 되겠죠??
    if (index != stockCardList.length - 1) {
      primaryColor = stockCardList[index].primaryColor;
      // emoji = stockCardList[index].emoji;
      title = stockCardList[index].title;
      totalValuationPrice = stockCardList[index].totalValuationPrice;
      holdingQuantity = stockCardList[index].holdingQuantity;
      purchasePrice = stockCardList[index].purchasePrice;
      currentStockPrice = stockCardList[index].currentStockPrice;
      buyPrice = stockCardList[index].buyPrice;
      buyQuantity = stockCardList[index].buyQuantity;
      totalValuationResultText = stockCardList[index].totalValuationResultText;
      valuationResultText = stockCardList[index].valuationResultText;
      yieldResultText = stockCardList[index].yieldResultText;
      yieldDiffText = stockCardList[index].yieldDiffText;
      purchasePriceResultText = stockCardList[index].purchasePriceResultText;
      averagePurchaseDiffText = stockCardList[index].averagePurchaseDiffText;
      valuationLossDiffText = stockCardList[index].valuationLossDiffText;

      notifyListeners();
    }
  }

  // 카드 더하기
  void addCard() {
    print('addCard() 실행');
    var newStockCard = StockCard(
      primaryColor: grey,
      // emoji: '🙂',
      title: '계산기 ${stockCardList.length}',
      totalValuationPrice: 0,
      holdingQuantity: 0,
      purchasePrice: 0,
      currentStockPrice: 0,
      buyPrice: 0,
      buyQuantity: 0,
      totalValuationResultText: '0 원',
      valuationResultText: '0 원',
      yieldResultText: '0.00 %',
      yieldDiffText: '',
      purchasePriceResultText: '0 원',
      averagePurchaseDiffText: '',
      valuationLossDiffText: '',
      tax: 0.25,
      tradingFee: 0.015,
      currency: '원',
      exchangeRate: 1130,
    );

    if (stockCardList.length == 2) {
      stockCardList.insert(1, newStockCard);
    } else {
      stockCardList.insert(stockCardList.length - 1, newStockCard);
    }

    loadUiByChangedPage(index: stockCardList.length - 2);

    // decreaseLastIndex();
    // main_screen에서도 textField관리해주기
    saveData();
    notifyListeners();
  }

  //카드 삭제
  void deleteCard({int index}) {
    // decreaseLastIndex();
    stockCardList.removeAt(index);
    // main_screen에서도 textField관리해주기
    saveData();
    notifyListeners();
  }

  //테스트용 stockCardList 초기화
  void clearList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('stockCardList');
    prefs.remove('lastIndex');
  }

  //                   마지막 캐러셀카드 index인지 판단용
  void setIsLastPage(bool result) {
    _isLastPage = result;
    notifyListeners();
  }

  bool get isLastPage {
    return _isLastPage;
  }

  int calculateTotalValuationSum() {
    int totalSum = 0;
    for (int i = 0; i < stockCardList.length - 1; i++) {
      totalSum += calcBrain.calculateNewTotalValuation(
          buyPrice: stockCardList[i].buyPrice,
          holdingQuantity: stockCardList[i].holdingQuantity,
          buyQuantity: stockCardList[i].buyQuantity);
    }
    return totalSum;
  }

  //* 매매수수료 저장
  void setTaxTradingFee({double tax}) {
    stockCardList[nowPageIndex].tax = tax;
    notifyListeners();
  }

  //* 매매수수료 저장
  void setTradingFee({double tradingFee}) {
    stockCardList[nowPageIndex].tradingFee = tradingFee;
    notifyListeners();
  }

  void setCurrency({String currency}) {
    stockCardList[nowPageIndex].currency = currency;
    notifyListeners();
  }

  void setExRate({double exRate}) {
    stockCardList[nowPageIndex].exchangeRate = exRate;
    notifyListeners();
  }

  String getFlag() {
    if (nowPageIndex != stockCardList.length - 1) {
      if (stockCardList[nowPageIndex].currency == '원') {
        return '(한)';
      } else if (stockCardList[nowPageIndex].currency == '달러') {
        return '(미)';
      } else {
        return '(코)';
      }
    } else {
      return '';
    }
  }

  //TODO: 원, 달러 (화폐단위)를 관리하는 메서드
  String getCurrency() {
    if (stockCardList[nowPageIndex].currency == '원') {
      return '[원]';
    } else {
      return '[달러]';
    }
  }

  //TODO: 음
}
