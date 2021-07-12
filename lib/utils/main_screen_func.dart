import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';

import 'utils.dart';

//* 캐러샐 슬라이드할 때 input값 갱신
void carouselOnPageChangedCb({
  UiDataProvider uiDataProvider,
  TextEditingController titleTEC,
  TextEditingController totalValuationPriceTEC,
  TextEditingController holdingQuantityTEC,
  TextEditingController purchasePriceTEC,
  TextEditingController currentStockPriceTEC,
  TextEditingController buyPriceTEC,
  TextEditingController buyQuantityTEC,
}) {
  titleTEC.text = uiDataProvider.title;
  totalValuationPriceTEC.text = uiDataProvider.totalValuationPrice.toString();
  holdingQuantityTEC.text = uiDataProvider.holdingQuantity.toString();
  purchasePriceTEC.text = uiDataProvider.purchasePrice.toString();
  currentStockPriceTEC.text = uiDataProvider.currentStockPrice.toString();
  buyPriceTEC.text = uiDataProvider.buyPrice.toString();
  buyQuantityTEC.text = uiDataProvider.buyQuantity.toString();
}

//* 텍스트 필드 clears
void clearTextField({
  TextEditingController totalValuationPriceTEC,
  TextEditingController holdingQuantityTEC,
  TextEditingController purchasePriceTEC,
  TextEditingController currentStockPriceTEC,
  TextEditingController buyPriceTEC,
  TextEditingController buyQuantityTEC,
}) {
  totalValuationPriceTEC.clear();
  holdingQuantityTEC.clear();
  purchasePriceTEC.clear();
  currentStockPriceTEC.clear();
  buyPriceTEC.clear();
  buyQuantityTEC.clear();
}

//* 계산버튼 콜백
void calculateButtonCB({
  UiDataProvider uiDataProvider,
  BuildContext context,
  CalcBrain calcBrain,
  TextEditingController totalValuationPriceTEC,
  TextEditingController holdingQuantityTEC,
  TextEditingController purchasePriceTEC,
  TextEditingController currentStockPriceTEC,
  TextEditingController buyPriceTEC,
  TextEditingController buyQuantityTEC,
}) {
  uiDataProvider.tabCalculateButton(context);

  //* shared_preferences textfield 데이터 저장
  setTextFieldData(
    totalValuationPriceTEC: totalValuationPriceTEC,
    holdingQuantityTEC: holdingQuantityTEC,
    purchasePriceTEC: purchasePriceTEC,
    currentStockPriceTEC: currentStockPriceTEC,
    buyPriceTEC: buyPriceTEC,
    buyQuantityTEC: buyQuantityTEC,
  );

  //*shared_preferences 내부 데이터들(중간계산, 결과값 등) 저장
  setInnerData(context, uiDataProvider);

  //* input의 컴마 살균
  sanitizingInputComma(
    calcBrain: calcBrain,
    totalValuationPriceTEC: totalValuationPriceTEC,
    holdingQuantityTEC: holdingQuantityTEC,
    purchasePriceTEC: purchasePriceTEC,
    currentStockPriceTEC: currentStockPriceTEC,
    buyPriceTEC: buyPriceTEC,
    buyQuantityTEC: buyQuantityTEC,
  );

  //stockCardList[nowPageIndex]에 데이터들 set
  uiDataProvider.setData();
}

//* 초기화버튼 콜백
void clearButtonCB({
  UiDataProvider uiDataProvider,
  BuildContext context,
  TextEditingController totalValuationPriceTEC,
  TextEditingController holdingQuantityTEC,
  TextEditingController purchasePriceTEC,
  TextEditingController currentStockPriceTEC,
  TextEditingController buyPriceTEC,
  TextEditingController buyQuantityTEC,
}) {
  uiDataProvider.tabClearButton(context);
  //텍스트필드 clear
  clearTextField();

  //shared_preferences textfield 데이터 저장
  setTextFieldData(
    totalValuationPriceTEC: totalValuationPriceTEC,
    holdingQuantityTEC: holdingQuantityTEC,
    purchasePriceTEC: purchasePriceTEC,
    currentStockPriceTEC: currentStockPriceTEC,
    buyPriceTEC: buyPriceTEC,
    buyQuantityTEC: buyQuantityTEC,
  );

  //shared_preferences 내부 데이터들(중간계산, 결과값 등) 저장
  setInnerDataForClear(context, uiDataProvider);

  //stockCardList[nowPageIndex]에 데이터들 set
  uiDataProvider.setData();
}

//*클리어버튼 눌렀을 때 데이터 초기화된 채로 저장
void setInnerDataForClear(
        BuildContext context, UiDataProvider uiDataProvider) =>
    uiDataProvider.saveDataForClear();

//*계산버튼 눌렀을 때 데이터 초기화된 채로 저장
//TODO(결과 저장의 콜백으로 변경 예정)
void setInnerData(BuildContext context, UiDataProvider uiDataProvider) =>
    uiDataProvider.saveData();

//input text의 컴마, -, 온점 살균
//TODO: 사용해야할 때가 올 것 같습니다.
void sanitizingInputComma({
  CalcBrain calcBrain,
  TextEditingController totalValuationPriceTEC,
  TextEditingController holdingQuantityTEC,
  TextEditingController purchasePriceTEC,
  TextEditingController currentStockPriceTEC,
  TextEditingController buyPriceTEC,
  TextEditingController buyQuantityTEC,
}) {
  totalValuationPriceTEC.text =
      calcBrain.sanitizeComma(totalValuationPriceTEC.text).toString();
  holdingQuantityTEC.text =
      calcBrain.sanitizeComma(holdingQuantityTEC.text).toString();
  purchasePriceTEC.text =
      calcBrain.sanitizeComma(purchasePriceTEC.text).toString();
  currentStockPriceTEC.text =
      calcBrain.sanitizeComma(currentStockPriceTEC.text).toString();
  buyPriceTEC.text = calcBrain.sanitizeComma(buyPriceTEC.text).toString();
  buyQuantityTEC.text = calcBrain.sanitizeComma(buyQuantityTEC.text).toString();
}

// 계산 버튼을 누르면 TextField input값들을 저장합니다.
void setTextFieldData({
  TextEditingController totalValuationPriceTEC,
  TextEditingController holdingQuantityTEC,
  TextEditingController purchasePriceTEC,
  TextEditingController currentStockPriceTEC,
  TextEditingController buyPriceTEC,
  TextEditingController buyQuantityTEC,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('totalValuationPriceTF', totalValuationPriceTEC.text);
  prefs.setString('holdingQuantityTF', holdingQuantityTEC.text);
  prefs.setString('purchasePriceTF', purchasePriceTEC.text);
  prefs.setString('currentStockPriceTF', currentStockPriceTEC.text);
  prefs.setString('buyPriceTF', buyPriceTEC.text);
  prefs.setString('buyQuantityTF', buyQuantityTEC.text);
}

//* Shared_preferences
//* 앱 실행 시, 저장돼있던 Data들을 불러옵니다.
void initData({
  BuildContext context,
  TextEditingController totalValuationPriceTEC,
  TextEditingController holdingQuantityTEC,
  TextEditingController purchasePriceTEC,
  TextEditingController currentStockPriceTEC,
  TextEditingController buyPriceTEC,
  TextEditingController buyQuantityTEC,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //TextField의 텍스트 로딩
  loadTextFieldData(
    prefs,
    totalValuationPriceTEC: totalValuationPriceTEC,
    holdingQuantityTEC: holdingQuantityTEC,
    purchasePriceTEC: purchasePriceTEC,
    currentStockPriceTEC: currentStockPriceTEC,
    buyPriceTEC: buyPriceTEC,
    buyQuantityTEC: buyQuantityTEC,
  );

  //* 내부 데이터들(중간계산, 결과값 등) 로딩
  loadInnerData(context);
}

//* 앱 실행 시, 저장돼있던 TextField input값들을 불러옵니다.
void loadTextFieldData(SharedPreferences prefs,
    {TextEditingController totalValuationPriceTEC,
    TextEditingController holdingQuantityTEC,
    TextEditingController purchasePriceTEC,
    TextEditingController currentStockPriceTEC,
    TextEditingController buyPriceTEC,
    TextEditingController buyQuantityTEC}) {
  totalValuationPriceTEC.text = prefs.getString('totalValuationPriceTF') ?? '';
  holdingQuantityTEC.text = prefs.getString('holdingQuantityTF') ?? '';
  purchasePriceTEC.text = prefs.getString('purchasePriceTF') ?? '';
  currentStockPriceTEC.text = prefs.getString('currentStockPriceTF') ?? '';
  buyPriceTEC.text = prefs.getString('buyPriceTF') ?? '';
  buyQuantityTEC.text = prefs.getString('buyQuantityTF') ?? '';
}

//* 앱 실행 시, 저장돼있던 ui_data_provider 데이터들을 불러옵니다.
void loadInnerData(BuildContext context) {
  Provider.of<UiDataProvider>(context, listen: false).loadData();
}
