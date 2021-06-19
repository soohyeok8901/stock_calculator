import 'package:averge_price_calc/models/ui_data.dart';
import 'package:flutter/material.dart';

class HandleUiDataProvider extends ChangeNotifier {
  List<UiData> _uiDataList = [
    UiData(
      title: '계산기 1',
    )
  ];

  String title;
  String result;
  String diff;
  String percent;

  int exStockPrice;
  int exStockCount;
  int newStockPrice;
  int newStockCount;

  TextEditingController exPriceTEC = TextEditingController();
  TextEditingController exCountTEC = TextEditingController();
  TextEditingController newPriceTEC = TextEditingController();
  TextEditingController newCountTEC = TextEditingController();
}
