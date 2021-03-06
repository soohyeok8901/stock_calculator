import 'dart:developer';

import 'package:stock_calculator/utils/calculator.dart';
import 'package:stock_calculator/models/stock_card.dart';
import 'package:stock_calculator/utils/string_func.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class UiDataProvider extends ChangeNotifier {
  //μΊλ¬μμ© DataClass List
  List<StockCard> stockCardList = [
    StockCard(
      primaryColor: grey,
      // emoji: 'π',
      title: 'κ³μ°κΈ° 1',
      totalValuationPrice: 0, //νκ°κΈμ‘
      holdingQuantity: 0, //λ³΄μ κ°μ
      purchasePrice: 0, // νμ¬νλ¨κ°
      currentStockPrice: 0, //νμ¬ μ£Όκ°
      buyPrice: 0, //κ΅¬λ§€κ°κ²©
      buyQuantity: 0, //κ΅¬λ§€μλ
      totalValuationResultText: '0 μ', //νκ°κΈμ‘ νμ€νΈ
      valuationResultText: '0 μ', //νκ°μμ΅ νμ€νΈ
      valuationLossDiffText: '', //νκ°κΈμ‘ - νκ°μμ΅ νμ€νΈ
      yieldResultText: '0.00 %', //μμ΅λ₯  νμ€νΈ
      yieldDiffText: '', // κ³μ°μμ΅λ₯  - κΈ°μ‘΄μμ΅λ₯  νμ€νΈ
      purchasePriceResultText: '0 μ', //κ³μ°λ νλ¨κ°
      averagePurchaseDiffText: '', //κ³μ°νλ¨κ° - κΈ°μ‘΄νλ¨κ° νμ€νΈ
      tax: 0.015,
      tradingFee: 0.25,
      currency: 'μ',
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
  // String emoji = 'π';

  //νμ΄ν
  String title;

  ///
  ///
  ///                           κ³μ°κΈ° κ΄λ ¨ λ³μ
  ///
  ///
  //Row1 - νμ¬ νκ°κΈμ‘, νμ¬ λ³΄μ μλ
  var totalValuationPrice;
  var holdingQuantity;

  //Row2 - λ§€μ λ¨κ°(νμ¬ νλ¨κ°), νμ¬ μ£Όκ°
  var purchasePrice;
  var currentStockPrice;

  //Row3 - κ΅¬λ§€ν  μ£Όμμ μμκ°κ²©, κ΅¬λ§€ν  μμμλ[μ£Ό]
  var buyPrice;
  var buyQuantity;

  //μ€κ°κ³μ°μ© - κΈ°μ‘΄ λ§€μμ΄μ‘, κΈ°μ‘΄ νκ° μμ΅, κΈ°μ‘΄ μμ΅λ₯ , κΈ°μ‘΄ νλ¨κ°
  //            κ΅¬λ§€ μ΄μ  λ³΄μ  μ£Όμμ κ³μ° κ²°κ³Όλ€ (νλ¨κ° μ°¨μ΄, μμ΅λ₯  μ°¨μ΄λ₯Ό μν λ³μλ€)
  var exTotalPurchase;
  var exValuationLoss;
  double exYield;
  var exAveragePurchase;

  //κ΅¬λ§€ μ΄ν κ³μ° κ²°κ³Όλ€ - (κ³μ°λ) λ§€μμ΄μ‘, νλ¨κ°, μμ΅λ₯ , (μ΄μ μμ΅λ₯ +κ³μ°μμ΅λ₯ ) νκ°κΈμ‘, νκ°μμ΅
  int calculatedTotalPurchase = 0;
  int calculatedAveragePurchase = 0;
  double calculatedYield = 0;
  int calculatedTotalValuation = 0;
  int calculatedValuationLoss = 0;

  //                          κ³μ° κ²°κ³Ό νμ€νΈλ€
  //κ³μ°λ νκ°μ΄μ‘, κ³μ°λ νκ°μμ΅
  String totalValuationResultText;
  String valuationResultText;
  //νκ°μμ΅ μ°¨μ΄
  int valuationLossDiff;
  String valuationLossDiffText;
  //κ³μ°λμμ΅λ₯ , μμ΅λ₯  μ°¨μ΄
  String yieldResultText;
  double yieldDiff;
  String yieldDiffText;
  //κ³μ°λ νλ¨κ°, νλ¨κ° μ°¨μ΄
  String purchasePriceResultText;
  int averagePurchaseDiff;
  String averagePurchaseDiffText;

  int nowPageIndex = 0;
  bool _isLastPage = false; // main_screen μμ main Container μ‘°κ±΄λΆ λ λλ§νλλ°μ μ¬μ©λ©λλ€.

  bool isEnd;

  ///μΈκΈ, λ§€λ§€μμλ£, ν΅ν, νμ¨
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

    //TextField ννΈ
    totalValuationPrice = prefs.getInt('totalValuationPrice') ?? 0;
    holdingQuantity = prefs.getInt('holdingQuantity') ?? 0;
    purchasePrice = prefs.getInt('purchasePrice') ?? 0;
    currentStockPrice = prefs.getInt('currentStockPrice') ?? 0;
    tax = prefs.getDouble('tax') ?? 0.25;
    tradingFee = prefs.getDouble('tradingFee') ?? 0.015;
    // buyPrice = prefs.getInt('buyPrice') ?? 0;
    // buyQuantity = prefs.getInt('buyQuantity') ?? 0;

    //μ€κ°κ³μ° ννΈ
    // exTotalPurchase = prefs.getInt('exTotalPurchase') ?? 0;

    //κ²°κ³Όκ° ννΈ
    //κ·Όλ° κ²°κ³Όκ°λ λ§μ½ μμΌλ©΄ 0μμΌλ‘ νκΈ°λκ² ν΄λμΌλκΉ μ μ₯ν  νμμμ
    totalValuationResultText =
        prefs.getString('totalValuationResultText') ?? '0 μ';
    valuationResultText = prefs.getString('valuationResultText') ?? '0 μ';
    yieldResultText = prefs.getString('yieldResultText') ?? '0.00 %';
    purchasePriceResultText =
        prefs.getString('purchasePriceResultText') ?? '0 μ';
    valuationLossDiffText = prefs.getString('valuationLossDiffText') ?? '';
    averagePurchaseDiffText = prefs.getString('averagePurchaseDiffText') ?? '';
    yieldDiffText = prefs.getString('yieldDiffText') ?? '';
    // emoji = prefs.getString('emoji') ?? 'π';
    calculatedYield = prefs.getDouble('calculatedYield') ?? 0;

    //μκΉ κ²°μ 
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);

    //stockCardList ννΈ
    var encodedListData = prefs.getString('stockCardList');
    if (encodedListData != null) {
      stockCardList = StockCard.decode(encodedListData);
    }

    nowPageIndex = prefs.getInt('nowPageIndex') ?? 0;

    notifyListeners();
  }

  void saveTotalValuationPriceData() async {
    print('save totalValuationPrice νκ°κΈμ‘');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (totalValuationPrice != null) {
      prefs.setInt('totalValuationPrice', totalValuationPrice);
    }
  }

  void saveHoldingQuantityData() async {
    print('save holdingQunatity λ³΄μ κ°μ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (holdingQuantity != null) {
      prefs.setInt('holdingQuantity', holdingQuantity);
    }
  }

  void savePurchasePriceData() async {
    print('save purchasePrice λ³΄μ κ°μ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (purchasePrice != null) {
      prefs.setInt('purchasePrice', purchasePrice);
    }
  }

  void saveCurrentStockPriceData() async {
    print('save currentStockPrice νμ¬μ£Όκ°');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentStockPrice != null) {
      prefs.setInt('currentStockPrice', currentStockPrice);
    }
  }

  void saveTaxData() async {
    print('save tax μΈκΈ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tax != null) {
      prefs.setDouble('tax', tax);
    }
  }

  void saveTradingFeeData() async {
    print('save tradingFee μΈκΈ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tradingFee != null) {
      prefs.setDouble('tradingFee', tradingFee);
    }
  }

  void saveData() async {
    print('saveData()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //μ€κ° κ³μ° ννΈ

    //κ²°κ³Όκ°(number)ννΈ

    //result text(String) ννΈ
    prefs.setString('totalValuationResultText', totalValuationResultText);
    prefs.setString('valuationResultText', valuationResultText);
    prefs.setString('yieldResultText', yieldResultText);
    prefs.setString('purchasePriceResultText', purchasePriceResultText);
    prefs.setString('valuationLossDiffText', valuationLossDiffText);
    prefs.setString('averagePurchaseDiffText', averagePurchaseDiffText);
    prefs.setString('yieldDiffText', yieldDiffText);
    // prefs.setString('emoji', emoji);
    prefs.setDouble('calculatedYield', calculatedYield);

    //stockCardList ννΈ
    //1. list μ§λ ¬ν
    var encodedListData = StockCard.encode(stockCardList);
    //2. μ§λ ¬νν listλ₯Ό setStringμΌλ‘ μ μ₯
    prefs.setString('stockCardList', encodedListData);

    //nowPageIndex μ μ₯
    prefs.setInt('nowPageIndex', nowPageIndex);
  }

  void saveDataForClear() async {
    print('saveDataForClear()');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //νλ ννΈ
    prefs.setInt('totalValuationPrice', 0);
    prefs.setInt('holdingQuantity', 0);
    prefs.setInt('purchasePrice', 0);
    prefs.setInt('currentStockPrice', 0);
    prefs.setDouble('tax', 0.00);
    prefs.setDouble('tradingFee', 0.00);

    //μ€κ° κ³μ° ννΈ

    //κ²°κ³Όκ°(number)ννΈ

    //result text(String) ννΈ
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

  ///                  UI, κ³μ°κΈ° κ΄λ ¨ methods
  ///
  ///
  //κ³μ° λ²νΌμ λλ μ λ, result text, diff text, percent text κ°±μ 
  void tabCalculateButton(BuildContext _) {
    print('tabCalcuateButton ν¨μ μ€ν');

    //κΈ°μ‘΄ λ§€μμ΄μ‘ μ€κ°κ³μ° <int>
    exTotalPurchase = calcBrain.calculateExTotalPurchase(
      purchasePrice: purchasePrice,
      holdingQuantity: holdingQuantity,
    );

    //κΈ°μ‘΄ νκ°μμ΅ μ€κ°κ³μ° <int>
    exValuationLoss = calcBrain.calculateExValuationLoss(
      totalValuationPrice: totalValuationPrice,
      totalPurchase: exTotalPurchase,
    );

    //κΈ°μ‘΄ μμ΅λ₯  κ³μ°
    exYield = calcBrain.calculateExYield(
      exValuationLoss: exValuationLoss,
      exTotalPurchase: exTotalPurchase,
    );

    //κΈ°μ‘΄ νλ¨κ° κ³μ°
    exAveragePurchase = calcBrain.calculateExPurchase(
      totalPurchase: exTotalPurchase,
      holdingQuantity: holdingQuantity,
    );

    // μλ‘μ΄ λ§€μμ΄μ‘ κ³μ°
    calculatedTotalPurchase = calcBrain.calculateNewTotalPurchase(
        exTotalPurchase: exTotalPurchase,
        buyPrice: buyPrice,
        buyQuantity: buyQuantity);

    // μλ‘μ΄ νλ¨κ° κ³μ°
    calculatedAveragePurchase = calcBrain.calculateNewAveragePurchase(
        calculatedTotalPurchase: calculatedTotalPurchase,
        holdingQuantity: holdingQuantity,
        buyQuantity: buyQuantity);

    // μλ‘μ΄ νκ°κΈμ‘ κ³μ°
    calculatedTotalValuation = calcBrain.calculateNewTotalValuation(
        buyPrice: buyPrice,
        holdingQuantity: holdingQuantity,
        buyQuantity: buyQuantity);

    // μλ‘μ΄ νκ°μμ΅ κ³μ°
    calculatedValuationLoss = calcBrain.calculateNewValuationLoss(
        calculatedTotalPurchase: calculatedTotalPurchase,
        calculatedTotalValuation: calculatedTotalValuation);

    // μλ‘μ΄ μμ΅λ₯  κ³μ°
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

    // νκ°μμ΅ μ°¨μ΄ κ³μ°
    valuationLossDiff = calcBrain.calculateValuationLoss(
        exValuationLoss: exValuationLoss,
        newValuationLoss: calculatedValuationLoss);

    // νλ¨κ° μ°¨μ΄ κ³μ°
    averagePurchaseDiff = calcBrain.calculateAveragePurchaseDiff(
        calculatedAveragePurchase: calculatedAveragePurchase,
        exAveragePurchase: exAveragePurchase);

    // μμ΅λ₯  μ°¨μ΄ κ³μ°
    if (calcBrain
        .calculateYieldDiff(calculatedYield: calculatedYield, exYield: exYield)
        .isNaN) {
      yieldDiff = 0;
    } else {
      yieldDiff = calcBrain.calculateYieldDiff(
          calculatedYield: calculatedYield, exYield: exYield);
    }

    //νμ€νΈν
    totalValuationResultText =
        '${currencyFormat(calcBrain.sanitizeComma(calculatedTotalValuation.toString()))} μ';
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

    //μμ΅λ₯  μ°¨μ΄, νλ¨κ° μ°¨μ΄ μμ μμ νλ¨μ© λ©μλ
    determineNegativeForValuationLossDiff();
    determineNegativeForYield();
    determineNegativeForAveragePurchase();

    //uiμ© μ, μ΄λͺ¨μ§
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);
    // emoji = calcBrain.setEmoji(yieldResult: calculatedYield);

    notifyListeners();
    //ν€λ³΄λ λκΈ°
    FocusScope.of(_).unfocus();
  }

  //μ΄κΈ°ν λ²νΌμ λλ μ λ result text, diff text, percent text μ΄κΈ°ν
  void tabClearButton(BuildContext _) {
    print('tabClearButton ν¨μ μ€ν');
    //ν€λ³΄λ λκΈ°
    FocusScope.of(_).unfocus();

    totalValuationResultText = '0 μ';
    yieldResultText = '0.00 %';
    purchasePriceResultText = '0 μ';
    valuationResultText = '0 μ';

    yieldDiffText = '';
    averagePurchaseDiffText = '';

    primaryColor = grey;
    // emoji = 'π';

    notifyListeners();
  }

  //                     νλκ°κ° λμλλ changeString λ©μλ
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

  //κ³μ°κ²°κ³Όμ μ°¨μ΄κ°μ λ°©ν₯νμ΄ν λΆμ΄κΈ°
  void determineNegativeForValuationLossDiff() {
    String data;
    if (valuationLossDiff < 0) {
      data = currencyFormat(valuationLossDiff);
      valuationLossDiffText = '($data μ)';
    } else if (yieldDiff == 0) {
      valuationLossDiffText = '';
    } else {
      data = currencyFormat(valuationLossDiff);
      valuationLossDiffText = '(+$data μ)';
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
      averagePurchaseDiffText = '($data μ)';
    } else if (averagePurchaseDiff == 0) {
      data = currencyFormat(averagePurchaseDiff);
      averagePurchaseDiffText = '';
    } else {
      data = currencyFormat(averagePurchaseDiff);
      averagePurchaseDiffText = '(+$data μ)';
    }
  }

  ///                     title Widget κ΄λ ¨
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

  ///                   Carousel Card κ΄λ ¨ methods
  ///
  void setData() {
    print('$nowPageIndex μ μ μ₯');
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
      print('μΆκ° μΉ΄λμλλ€. μ μ₯ λΆκ°λ₯');
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

  //μΊλ¬μ onPageChanged λ¦¬μ€λμ© data Load λ©μλ
  //ui κ°λ€μ List[i] κ°μΌλ‘ μ λΆ μμ  (νμ΄μ§μ¬λΌμ΄λμ λμ)
  void loadUiByChangedPage({int index}) {
    print('μΈλ±μ€ $index λ§μ§λ§μΈλ±μ€ ${stockCardList.length - 1} ');

    //μΈλ±μ€μ λ°λ₯Έ λ°μ΄ν°λ€μ νλλ€μ μ μ₯νλ©΄ λκ² μ£ ??
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

  // μΉ΄λ λνκΈ°
  void addCard() {
    print('addCard() μ€ν');
    var newStockCard = StockCard(
      primaryColor: grey,
      // emoji: 'π',
      title: 'κ³μ°κΈ° ${stockCardList.length}',
      totalValuationPrice: 0,
      holdingQuantity: 0,
      purchasePrice: 0,
      currentStockPrice: 0,
      buyPrice: 0,
      buyQuantity: 0,
      totalValuationResultText: '0 μ',
      valuationResultText: '0 μ',
      yieldResultText: '0.00 %',
      yieldDiffText: '',
      purchasePriceResultText: '0 μ',
      averagePurchaseDiffText: '',
      valuationLossDiffText: '',
      tax: 0.25,
      tradingFee: 0.015,
      currency: 'μ',
      exchangeRate: 1130,
    );

    if (stockCardList.length == 2) {
      stockCardList.insert(1, newStockCard);
    } else {
      stockCardList.insert(stockCardList.length - 1, newStockCard);
    }

    loadUiByChangedPage(index: stockCardList.length - 2);

    // decreaseLastIndex();
    // main_screenμμλ textFieldκ΄λ¦¬ν΄μ£ΌκΈ°
    saveData();
    notifyListeners();
  }

  //μΉ΄λ μ­μ 
  void deleteCard({int index}) {
    // decreaseLastIndex();
    stockCardList.removeAt(index);
    // main_screenμμλ textFieldκ΄λ¦¬ν΄μ£ΌκΈ°
    saveData();
    notifyListeners();
  }

  //νμ€νΈμ© stockCardList μ΄κΈ°ν
  void clearList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('stockCardList');
    prefs.remove('lastIndex');
  }

  //                   λ§μ§λ§ μΊλ¬μμΉ΄λ indexμΈμ§ νλ¨μ©
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

  //* λ§€λ§€μμλ£ μ μ₯
  void setTaxTradingFee({double tax}) {
    stockCardList[nowPageIndex].tax = tax;
    notifyListeners();
  }

  //* λ§€λ§€μμλ£ μ μ₯
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
      if (stockCardList[nowPageIndex].currency == 'μ') {
        return '(ν)';
      } else if (stockCardList[nowPageIndex].currency == 'λ¬λ¬') {
        return '(λ―Έ)';
      } else {
        return '(μ½)';
      }
    } else {
      return '';
    }
  }

  //TODO: μ, λ¬λ¬ (ννλ¨μ)λ₯Ό κ΄λ¦¬νλ λ©μλ
  String getCurrency() {
    if (stockCardList[nowPageIndex].currency == 'μ') {
      return '[μ]';
    } else {
      return '[λ¬λ¬]';
    }
  }

  //TODO: μ
}
