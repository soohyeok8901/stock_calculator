import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:averge_price_calc/utils/string_func.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class UiDataProvider extends ChangeNotifier {
  //캐러샐용 DataClass List
  List<StockCard> stockCardList = [
    StockCard(
      primaryColor: grey,
      emoji: '🙂',
      title: '계산기 1',
      totalValuationPrice: 0,
      holdingQuantity: 0,
      purchasePrice: 0,
      currentStockPrice: 0,
      buyPrice: 0,
      buyQuantity: 0,
      totalValuationResultText: '0 원',
      valuationResultText: '0 원',
      valuationLossDiffText: '',
      yieldResultText: '0.00 %',
      yieldDiffText: '',
      purchasePriceResultText: '0 원',
      averagePurchaseDiffText: '',
    ),
    StockCard(
      primaryColor: null,
      emoji: null,
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
  //Row1 - 현재 평가금액, 현재 보유수량
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
  bool _isLastPage = false;

  bool isFirst;
  bool isEnd;

  CalcBrain calcBrain = CalcBrain();

  ///                 shared_preferences methods
  ///
  ///
  void loadData() async {
    print('loadData()');
    // clearList();
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
    valuationLossDiffText = prefs.getString('valuationLossDiffText');
    averagePurchaseDiffText = prefs.getString('averagePurchaseDiffText');
    yieldDiffText = prefs.getString('yieldDiffText');
    emoji = prefs.getString('emoji');
    calculatedYield = prefs.getDouble('calculatedYield');

    //색깔 결정
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);

    //stockCardList 파트
    var encodedListData = prefs.getString('stockCardList');
    if (encodedListData != null) {
      stockCardList = StockCard.decode(encodedListData);
    }

    nowPageIndex = prefs.getInt('nowPageIndex');

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
    prefs.setString('valuationLossDiffText', valuationLossDiffText);
    prefs.setString('averagePurchaseDiffText', averagePurchaseDiffText);
    prefs.setString('yieldDiffText', yieldDiffText);
    prefs.setString('emoji', emoji);
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
    prefs.setInt('buyPrice', 0);
    prefs.setInt('buyQuantity', 0);

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
    prefs.setString('emoji', emoji);
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
    yieldResultText = '0.00 %';
    purchasePriceResultText = '0 원';
    valuationResultText = '0 원';

    yieldDiffText = '';
    averagePurchaseDiffText = '';

    primaryColor = grey;
    emoji = '🙂';

    notifyListeners();
  }

  //                     필드각각 대응되는 changeString 메서드
  void changeTitleData(String newData) {
    title = newData;
    // setData();
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
      stockCardList[nowPageIndex].emoji = emoji;

      stockCardList[nowPageIndex].totalValuationPrice = totalValuationPrice;
      stockCardList[nowPageIndex].holdingQuantity = holdingQuantity;
      stockCardList[nowPageIndex].purchasePrice = purchasePrice;
      stockCardList[nowPageIndex].currentStockPrice = currentStockPrice;
      stockCardList[nowPageIndex].buyPrice = buyPrice;
      stockCardList[nowPageIndex].buyQuantity = buyQuantity;
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
      emoji = stockCardList[index].emoji;
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
      emoji: '🙂',
      title: '계산기 ${stockCardList.length - 1}',
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
}
