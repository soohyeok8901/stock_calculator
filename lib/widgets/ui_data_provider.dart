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

  //Row1 - 총 평가금액, 총 보유수량
  String totalValuationPrice;
  String holdingQuantity;

  //Row2 - 매입 단가(현재 평단가), 현재 주가
  String purchasePrice;
  String currentStockPrice;

  //Row3 - 구매할 주식의 예상가격, 구매할 예상수량[주]
  String buyPrice;
  String buyCount;

  //중간계산용 - 매입총액, 평가 손익
  int totalPurchasePrice;
  int valuation;

  //구매 이전 보유 주식의 계산 결과들 - 기존 평가총액, 기존 평가손익, 기존 수익률, 기존 평단가
  //중간계산용입니다.
  String originTotalValuationResultText;
  String originvaluationResultText;
  String originyieldResultText;
  String originpurchasePriceResultText;

  //계산 결과 텍스트들 - 계산된 평가총액, 계산된 평가손익, 계산된 수익률, 계산된 평단가
  String totalValuationResultText;
  String valuationResultText;
  String yieldResultText;
  String purchasePriceResultText;

  /// TextEditingControllers
  //title
  TextEditingController titleTEC = TextEditingController();

  //Row1
  TextEditingController totalValuationPriceTEC = TextEditingController();
  TextEditingController holdingQuantityTEC = TextEditingController();

  //Row2
  TextEditingController purchasePriceTEC = TextEditingController();
  TextEditingController currentStockPriceTEC = TextEditingController();

  //Row3
  TextEditingController buyPriceTEC = TextEditingController();
  TextEditingController buyCountTEC = TextEditingController();

  int nowPageIndex = 0;

  CalcBrain calcBrain = CalcBrain();

  //ui 값들을 List[i] 값으로 전부 수정 (페이지슬라이드시 동작)
  void setData() {
    notifyListeners();
  }

  //TextField 유효성 체크
  bool validate(String text) {
    if (text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

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

    //TODO: 지금 테스트 중입니다. 현재 평가손익, 수익률을 구할 수 있는가
    // 평가금액, 평가손익, 수익률 순으로 나와야합니다.
    // 물타기를 아직 고려하지 않은 계산입니다.

    //평가총액
    totalValuationResultText =
        '${currencyFormat(int.parse(totalValuationPrice))} 원';

    //매입총액 중간계산 <int>
    totalPurchasePrice = calcBrain.calculateTotalPurchase(
      purchasePrice: purchasePrice,
      holdingQuantity: holdingQuantity,
    );

    //평가손익 중간계산 <int>
    valuation = calcBrain.calculateValuation(
      totalValuationPrice: totalValuationPrice,
      totalPurchase: totalPurchasePrice,
    );

    //평가손익 텍스트화
    valuationResultText = addSuffixWonWithBrackets(currencyFormat(valuation));

    //수익률 계산
    yieldResultText = addSuffixPercent(calcBrain.calculateYield(
      valuation: valuation,
      totalPurchase: totalPurchasePrice,
    ));

    //평단가 계산
    purchasePriceResultText = addSuffixWon(calcBrain.calculatePurchasePrice(
      totalPurchase: totalPurchasePrice,
      holdingQuantity: holdingQuantity,
    ));

    primaryColor = calcBrain.setColor(
        yieldResult: calcBrain.calculateYield(
      valuation: valuation,
      totalPurchase: totalPurchasePrice,
    ));

    emoji = calcBrain.setEmoji(
        yieldResult: calcBrain.calculateYield(
      valuation: valuation,
      totalPurchase: totalPurchasePrice,
    ));
    notifyListeners();
    //키보드 끄기
    FocusScope.of(_).unfocus();

    //TODO: 그리고 계산식 적용, 컴마살균고치기, 텍스트필드 값 입력값 null이면 FN적용 에러메시지출력
    //TODO: 아이콘버튼 다루기
  }

  //초기화 버튼을 눌렀을 때 result text, diff text, percent text 초기화
  void tabClearButton(BuildContext _) {
    print('tabClearButton 함수 실행');
    //키보드 끄기
    FocusScope.of(_).unfocus();

    totalValuationResultText = null;
    valuationResultText = null;
    yieldResultText = null;
    purchasePriceResultText = null;

    totalValuationPriceTEC.clear();
    holdingQuantityTEC.clear();
    purchasePriceTEC.clear();
    currentStockPriceTEC.clear();
    buyPriceTEC.clear();
    buyCountTEC.clear();

    primaryColor = null;
    emoji = null;

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
    // print(price);
    final formatCurrency = new NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: 0);
    return formatCurrency.format(price);
    // print(formatCurrency.format(calcResult));
    // notifyListeners();
  }

  //컨트롤러 텍스트 필드화
  void controllerTextToFields() {
    totalValuationPrice = totalValuationPriceTEC.text;
    holdingQuantity = holdingQuantityTEC.text;
    purchasePrice = purchasePriceTEC.text;
    currentStockPrice = currentStockPriceTEC.text;
    buyPrice = buyPriceTEC.text;
    buyCount = buyCountTEC.text;
  }

  String addSuffixWonWithBrackets(String value) {
    return '($value 원)';
  }

  String addSuffixPercent(double value) {
    return '${value.toStringAsFixed(2)}%';
  }

  String addSuffixWon(int value) {
    return '${value.toString()} 원';
  }
}
