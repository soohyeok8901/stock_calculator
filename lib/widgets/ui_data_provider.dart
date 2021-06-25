import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class HandleUiDataProvider extends ChangeNotifier {
  //Carousel Slider에도 사용할 예정
  List<StockCard> _uiDataList = [
    StockCard(
      title: '계산기 1',
      result: '0 원',
      diff: null,
      percent: null,
    )
  ];

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

  /////////////////구매 이후 계산 결과들 - (계산된) 매입총액, 평단가, 수익률, 평가금액, 평가손익
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
  ///
  ///
  ///
  ///
  ////////////////////// TextEditingControllers
  //title
  TextEditingController titleTEC = TextEditingController();
  FocusNode titleFN = FocusNode();

  //Row1
  TextEditingController totalValuationPriceTEC = TextEditingController();
  FocusNode totalValuationPriceFN = FocusNode();

  TextEditingController holdingQuantityTEC = TextEditingController();
  FocusNode holdingQuantityFN = FocusNode();

  //Row2
  TextEditingController purchasePriceTEC = TextEditingController();
  FocusNode purchasePriceFN = FocusNode();
  TextEditingController currentStockPriceTEC = TextEditingController();
  FocusNode currentStockPriceFN = FocusNode();

  //Row3
  TextEditingController buyPriceTEC = TextEditingController();
  FocusNode buyPriceFN = FocusNode();
  TextEditingController buyQuantityTEC = TextEditingController();
  FocusNode buyQuantityFN = FocusNode();

  int nowPageIndex = 0;

  CalcBrain calcBrain = CalcBrain();

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

  // bool checkValidation(){
  //   if()
  // }

  //percent TextField 유효성 체크
  bool percentValidate(String text, int nowPercent) {
    if (!validate(text)) {
      print(nowPercent);
      if (nowPercent < -100) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //계산 버튼을 눌렀을 때, result text, diff text, percent text 갱신
  void tabCalculateButton(BuildContext _) {
    print('tabCalcuateButton 함수 실행');

    //Controller text fields화
    controllerTextToFields();

    //컴마, 온점 살균
    applySanitizeComma();

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
    print(calculatedValuationLoss);
    yieldResultText = addSuffixPercent(calculatedYield);
    purchasePriceResultText = addSuffixWon(calculatedAveragePurchase);

    // 수익률 차이, 평단가 차이 음수 양수 판단용 메서드
    determineNegativeForYield();
    determineNegativeForAveragePurchase();

    ///
    ///
    ///
    ///////////////////////ui용 색, 이모지
    primaryColor = calcBrain.setColor(yieldResult: calculatedYield);

    emoji = calcBrain.setEmoji(yieldResult: calculatedYield);
    notifyListeners();
    //키보드 끄기
    FocusScope.of(_).unfocus();

    //TODO: 텍스트필드 값 입력값 null이면 FN적용 에러메시지출력
    //TODO: 아이콘버튼 다루기
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

    totalValuationPriceTEC.clear();
    holdingQuantityTEC.clear();
    purchasePriceTEC.clear();
    currentStockPriceTEC.clear();
    buyPriceTEC.clear();
    buyQuantityTEC.clear();

    primaryColor = grey;
    emoji = '🙂';

    notifyListeners();
  }

  //계산, 초기화, 타이틀 수정 시 해당 List[i]의 data들 해당 ui의 data들로 수정
  //TODO: 이제 이거 하면 됨
  void modifyData() {
    notifyListeners();
  }

  void modifyTitle() {
    notifyListeners();
  }

  //list[i-2] 에 새로운 요소 추가 (카드 추가시)
  void addData() {
    if (_uiDataList.length == 2) {
      _uiDataList.insert(
        _uiDataList.length - 1,
        StockCard(title: '계산기 ${_uiDataList.length - 1}'),
      );
    } else if (_uiDataList.length == 3) {
      _uiDataList.insert(
        _uiDataList.length - 1,
        StockCard(title: '계산기 ${_uiDataList.length - 1}'),
      );
    } else {
      _uiDataList.insert(
        _uiDataList.length - 2,
        StockCard(title: '계산기 ${_uiDataList.length - 2}'),
      );
    }
    notifyListeners();
  }

  //카드 추가 (추가 카드 눌렀을 때 동작할 이벤트)
  void addCard() {
    addData();
  }

  void deleteData(int index) {
    _uiDataList.removeAt(index);
    notifyListeners();
  }

  //카드 삭제 list[i] 번째 데이터 삭제하면 됨
  void deleteCard(int index) {
    deleteData(index);
  }

  String currencyFormat(int price) {
    final formatCurrency = new NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return formatCurrency.format(price);
    // notifyListeners();
  }

  //컨트롤러 텍스트 필드화 (살균 적용)
  void controllerTextToFields() {
    totalValuationPrice = calcBrain.sanitizeComma(totalValuationPriceTEC.text);
    holdingQuantity = calcBrain.sanitizeComma(holdingQuantityTEC.text);
    purchasePrice = calcBrain.sanitizeComma(purchasePriceTEC.text);
    currentStockPrice = calcBrain.sanitizeComma(currentStockPriceTEC.text);
    buyPrice = calcBrain.sanitizeComma(buyPriceTEC.text);
    buyQuantity = calcBrain.sanitizeComma(buyQuantityTEC.text);
    notifyListeners();
  }

  //TextField에 전부 sanitizeComma 적용
  void applySanitizeComma() {
    totalValuationPriceTEC.text =
        calcBrain.sanitizeComma(totalValuationPriceTEC.text).toString();
    holdingQuantityTEC.text =
        calcBrain.sanitizeComma(holdingQuantityTEC.text).toString();
    purchasePriceTEC.text =
        calcBrain.sanitizeComma(purchasePriceTEC.text).toString();
    currentStockPriceTEC.text =
        calcBrain.sanitizeComma(currentStockPriceTEC.text).toString();
    buyPriceTEC.text = calcBrain.sanitizeComma(buyPriceTEC.text).toString();
    buyQuantityTEC.text =
        calcBrain.sanitizeComma(buyQuantityTEC.text).toString();
  }

  void determineNegativeForYield() {
    if (yieldDiff < 0) {
      yieldDiffText = '${yieldDiff.toStringAsFixed(2)} % ↓';
    } else {
      yieldDiffText = '${yieldDiff.toStringAsFixed(2)} % ↑';
    }
  }

  void determineNegativeForAveragePurchase() {
    if (averagePurchaseDiff < 0) {
      averagePurchaseDiffText = '$averagePurchaseDiff ↓';
    } else {
      averagePurchaseDiffText = '$averagePurchaseDiff ↑';
    }
  }

  String addSuffixWonWithBrackets(String value) {
    return '($value 원)';
  }

  String addSuffixPercent(double value) {
    return '${value.toStringAsFixed(2)} %';
  }

  String addSuffixWon(int value) {
    return '${value.toString()} 원';
  }
}
