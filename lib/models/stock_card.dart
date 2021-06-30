import 'package:flutter/cupertino.dart';

//data class
class StockCard {
  StockCard(
      {this.exStockPrice,
      this.exStockCount,
      this.newStockPrice,
      this.newStockCount,
      this.result,
      this.percent,
      this.title,
      this.diff,
      this.isEnd = false});
  int exStockPrice;
  int exStockCount;
  int newStockPrice;
  int newStockCount;
  String result;
  String title;
  String diff;
  String percent;

  bool isEnd;
}
