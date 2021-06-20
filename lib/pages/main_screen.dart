import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/widgets/CardCarousel.dart';
import 'package:averge_price_calc/widgets/InputTextField.dart';
import 'package:averge_price_calc/widgets/TitleTextField.dart';
import 'package:averge_price_calc/widgets/banner_ad.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _exStockPriceController = TextEditingController();
  final TextEditingController _exStockCountController = TextEditingController();
  final TextEditingController _newStockPriceController =
      TextEditingController();
  final TextEditingController _newStockCountController =
      TextEditingController();
  final TextEditingController _titleTextContorller = TextEditingController();
  final TextEditingController _percentTextController = TextEditingController();

  final FocusNode _percentFN = FocusNode();
  @override
  void dispose() {
    _exStockPriceController.dispose();
    _exStockCountController.dispose();
    _newStockPriceController.dispose();
    _newStockCountController.dispose();
    _titleTextContorller.dispose();
    _percentTextController.dispose();
    _percentFN.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: Shared preference 쓰면 되겠죠? 확인 후 필요없으면 삭제
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HandleUiDataProvider, CalcBrain>(
      builder: (context, handleUiDataProvider, calcBrain, widget) {
        //callbacks
        Function calculateButtonCB = () {
          handleUiDataProvider.tabCalculateButton(context);
        };

        Function clearButtonCB = () {
          handleUiDataProvider.tabClearButton(context);
        };

        return Scaffold(
          backgroundColor: Provider.of<CalcBrain>(context).primaryColor ?? grey,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      // height: 170,
                      child: Text(
                        '😱😥😰',
                        style: TextStyle(
                          fontSize: 90,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CardCarousel(),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(19),
                        topLeft: Radius.circular(19),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TitleTextField(
                            titleTextController: handleUiDataProvider.titleTEC,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    buildExTextFieldColumn(context),
                                    SizedBox(height: 10),
                                    buildExTextFieldColumn2(context),
                                    SizedBox(height: 5),
                                    Divider(
                                      height: 10,
                                      thickness: 1.22,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5),
                                    buildNewTextFieldColumn(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 14.0),
                            child: Column(
                              children: [
                                buildCalculator(
                                    context, calculateButtonCB, clearButtonCB),
                                SizedBox(height: 10),
                                ShowBannerAd(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCalculator(
      BuildContext context, Function calcCB, Function clearCB) {
    return Consumer2<HandleUiDataProvider, CalcBrain>(
      builder: (context, handleUiDataProvider, calcBrain, widget) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //평단가
                  Text(
                    handleUiDataProvider.averageText ?? '0 원',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  //차익
                  Text(
                    handleUiDataProvider.diffText ?? '',
                    style: TextStyle(
                      fontSize: 17,
                      textBaseline: TextBaseline.alphabetic,
                      fontWeight: FontWeight.bold,
                      // color: Provider.of<CalcBrain>(context).priceDiff[0] == '-'
                      //     ? Colors.indigoAccent[700]
                      //     : Colors.red,
                      fontFamily: 'Cafe24Simplehae',
                    ),
                  ),
                  //수익률
                  Text(
                    handleUiDataProvider.percentText ?? '',
                    style: TextStyle(
                      fontSize: 17,
                      textBaseline: TextBaseline.alphabetic,
                      fontWeight: FontWeight.bold,
                      // color: Provider.of<CalcBrain>(context).priceDiff[0] == '-'
                      //     ? Colors.indigoAccent[700]
                      //     : Colors.red,
                      fontFamily: 'Cafe24Simplehae',
                    ),
                  ),
                ],
              ),
              //button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      minWidth: 30,
                      height: 30,
                      color: Colors.blue,
                      child: Text(
                        '초기화',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                        ),
                      ),
                      onPressed: clearCB,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: MaterialButton(
                      minWidth: 30,
                      height: 30,
                      color: Colors.blue,
                      child: Text(
                        '계산',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                        ),
                      ),
                      onPressed: calcCB,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildNewTextFieldColumn(BuildContext context) {
    return Consumer<HandleUiDataProvider>(
      builder: (context, handleUiDataProvider, widget) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: handleUiDataProvider.buyPriceTEC,
                    hintText: '가격 입력',
                    titleText: '구매할 주식의 예상가격',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputTextField(
                    textController: handleUiDataProvider.buyCountTEC,
                    hintText: '개수 입력',
                    titleText: '구매할 예상 수량[주]',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildExTextFieldColumn(BuildContext context) {
    return Consumer<HandleUiDataProvider>(
      builder: (context, handleUiDataProvider, __) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: handleUiDataProvider.totalValuationPriceTEC,
                    hintText: '가격 입력',
                    titleText: '총 평가금액 (평가 손익 X)',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputTextField(
                    textController: handleUiDataProvider.holdingQuantityTEC,
                    hintText: '개수 입력',
                    titleText: '총 보유수량[주]',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildExTextFieldColumn2(BuildContext context) {
    return Consumer<HandleUiDataProvider>(
      builder: (context, handleUiDataProvider, __) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: handleUiDataProvider.purchasePriceTEC,
                    hintText: '가격 입력',
                    titleText: '매입 단가 (현재 평단가)',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputTextField(
                    textController: handleUiDataProvider.currentStockPriceTEC,
                    hintText: '개수 입력',
                    titleText: '현재 주가',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
