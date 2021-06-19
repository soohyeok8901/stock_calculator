import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HandleUiDataProvider extends ChangeNotifier {
  //Carousel Slider에도 사용할 예정
  List<StockCard> _uiDataList = [
    StockCard(
      title: '계산기 1',
    )
  ];

  String title;
  int average;
  String averageText;
  int diff;
  String diffText;
  double percent;
  String percentText;

  int exStockPrice;
  int exStockCount;
  int newStockPrice;
  int newStockCount;

  TextEditingController exPriceTEC = TextEditingController();
  TextEditingController exCountTEC = TextEditingController();
  TextEditingController newPriceTEC = TextEditingController();
  TextEditingController newCountTEC = TextEditingController();
  TextEditingController percentTEC = TextEditingController();
  FocusNode percentFN = FocusNode();
  TextEditingController titleTEC = TextEditingController();

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

    FocusScope.of(_).unfocus();

    //평단가(result) text 갱신
    average = calcBrain.calculateAverage(
      exSCount: exCountTEC.text,
      exSPrice: exPriceTEC.text,
      newSCount: newCountTEC.text,
      newSPrice: newPriceTEC.text,
    );
    averageText = '${currencyFormat(average)} 원';

    // 차익(diff) 갱신
    diff = calcBrain.calculateDiff(
      exStockPrice: exPriceTEC.text,
      average: average,
    );
    print(diff);
    diffText = '${currencyFormat(diff)} 원';

    //수익률(percent) 갱신
    percent = calcBrain.calculatePercent(
      exStockPrice: exPriceTEC.text,
      average: average,
    );
    percentText = '(${percent.toString()} %)';

    notifyListeners();
  }

  //초기화 버튼을 눌렀을 때 result text, diff text, percent text 초기화
  void tabClearButton(BuildContext _) {
    print('tabClearButton 함수 실행');
    FocusScope.of(_).unfocus();

    averageText = null;
    diffText = null;
    percentText = null;
    exPriceTEC.clear();
    exCountTEC.clear();
    newPriceTEC.clear();
    newCountTEC.clear();

    notifyListeners();
  }

  //계산인지 초기화인지 타이틀수정인지 확인
  void checkCase() {}

  //계산, 초기화, 타이틀 수정 시 해당 List[i]의 data들 해당 ui의 data들로 수정
  void modifyData() {
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
}
