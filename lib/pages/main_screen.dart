import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/widgets/InputTextField.dart';
import 'package:averge_price_calc/widgets/banner_ad.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _totalValuationPriceTEC = TextEditingController();
  final TextEditingController _holdingQuantityTEC = TextEditingController();
  final TextEditingController _purchasePriceTEC = TextEditingController();
  final TextEditingController _currentStockPriceTEC = TextEditingController();
  final TextEditingController _buyPriceTEC = TextEditingController();
  final TextEditingController _buyQuantityTEC = TextEditingController();

  @override
  void dispose() {
    _titleTEC.dispose();
    _totalValuationPriceTEC.dispose();
    _holdingQuantityTEC.dispose();
    _purchasePriceTEC.dispose();
    _currentStockPriceTEC.dispose();
    _buyPriceTEC.dispose();
    _buyQuantityTEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: Shared preference 쓰면 되겠죠? 확인 후 필요없으면 삭제
    //TODO: 디자인 반응형으로 만들기

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HandleUiDataProvider, CalcBrain>(
      builder: (context, handleUiDataProvider, calcBrain, widget) {
        //callbacks
        Function calculateButtonCB = () {
          handleUiDataProvider.tabCalculateButton(context);

          _totalValuationPriceTEC.text =
              calcBrain.sanitizeComma(_totalValuationPriceTEC.text).toString();
          _holdingQuantityTEC.text =
              calcBrain.sanitizeComma(_holdingQuantityTEC.text).toString();
          _purchasePriceTEC.text =
              calcBrain.sanitizeComma(_purchasePriceTEC.text).toString();
          _currentStockPriceTEC.text =
              calcBrain.sanitizeComma(_currentStockPriceTEC.text).toString();
          _buyPriceTEC.text =
              calcBrain.sanitizeComma(_buyPriceTEC.text).toString();
          _buyQuantityTEC.text =
              calcBrain.sanitizeComma(_buyQuantityTEC.text).toString();
        };

        Function clearButtonCB = () {
          handleUiDataProvider.tabClearButton(context);
          _totalValuationPriceTEC.clear();
          _holdingQuantityTEC.clear();
          _purchasePriceTEC.clear();
          _currentStockPriceTEC.clear();
          _buyPriceTEC.clear();
          _buyQuantityTEC.clear();
        };

        return Scaffold(
          backgroundColor: handleUiDataProvider.primaryColor,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      // height: 170,

                      child: Text(
                        handleUiDataProvider.emoji,
                        style: TextStyle(
                          fontSize: 100,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      // padding: EdgeInsets.all(2),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 7),
                      child: Container(),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 10, 50, 20),
                            child: Container(),
                            // child: TitleTextField(
                            //   context: context,
                            //   titleTextController: _titleTEC,
                            //   onChangedCB: (newData) {
                            //     handleUiDataProvider.changeTitleData(newData);
                            //   },
                            //   onPressedCB: () {
                            //     //해당 pageIndex의 stock_card데이터의 title데이터 수정해야함.
                            //   },
                            // ),
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
              //button
              buildButton(clearCB: clearCB, calcCB: calcCB, context: context),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: AutoSizeText(
                          '평가총액',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 15),

                      //평가총액
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          handleUiDataProvider.totalValuationResultText ??
                              '0 원',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 15),
                      //평가손익
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          handleUiDataProvider.valuationResultText ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: handleUiDataProvider.primaryColor,
                            fontFamily: 'Cafe24Simplehae',
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: AutoSizeText(
                          '수익률',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      //수익률
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          handleUiDataProvider.yieldResultText ?? '0 %',
                          style: TextStyle(
                            fontSize: 23,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: handleUiDataProvider.primaryColor,
                            fontFamily: 'Cafe24Simplehae',
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 10),

                      Expanded(
                        flex: 4,
                        // child: Container(),
                        child: AutoSizeText(
                          handleUiDataProvider.yieldDiffText ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Cafe24Simplehae',
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: AutoSizeText(
                          '평단가  ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          handleUiDataProvider.purchasePriceResultText ?? '0 원',
                          style: TextStyle(
                            fontSize: 23,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cafe24Simplehae',
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        // child: Container(),
                        child: AutoSizeText(
                          handleUiDataProvider.averagePurchaseDiffText ?? '',
                          style: TextStyle(
                            fontSize: 23,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Cafe24Simplehae',
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildButton(
      {Function clearCB, Function calcCB, BuildContext context}) {
    return Consumer<HandleUiDataProvider>(
      builder: (_, handleUiDataProvider, __) {
        return Row(
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
                elevation: 8,
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
                onPressed: _checkValidation() ? calcCB : null,
                disabledColor: grey,
                elevation: 8,
              ),
            ),
          ],
        );
      },
    );
  }

  bool _checkValidation() {
    return ((_totalValuationPriceTEC.text.length > 0) &&
        (_holdingQuantityTEC.text.length > 0) &&
        (_purchasePriceTEC.text.length > 0) &&
        (_currentStockPriceTEC.text.length > 0) &&
        (_buyPriceTEC.text.length > 0) &&
        (_buyQuantityTEC.text.length > 0));
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
                    textController: _buyPriceTEC,
                    hintText: '가격 입력',
                    titleText: '미래의 예상 주가',
                    onChangedCB: (newData) {
                      Provider.of<HandleUiDataProvider>(context, listen: false)
                          .changeBuyPriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputTextField(
                    textController: _buyQuantityTEC,
                    hintText: '개수 입력',
                    titleText: '구매 수량[주] (0주 가능)',
                    onChangedCB: (newData) {
                      Provider.of<HandleUiDataProvider>(context, listen: false)
                          .changeBuyQuantityData(newData);
                    },
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
                    textController: _totalValuationPriceTEC,
                    hintText: '가격 입력',
                    titleText: '평가 금액 (평가 손익 X)',
                    onChangedCB: (newData) {
                      Provider.of<HandleUiDataProvider>(context, listen: false)
                          .changeTotalValuationPriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputTextField(
                    textController: _holdingQuantityTEC,
                    hintText: '개수 입력',
                    titleText: '현재 보유수량[주]',
                    onChangedCB: (newData) {
                      Provider.of<HandleUiDataProvider>(context, listen: false)
                          .changeHoldingQuantityData(newData);
                    },
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
                    textController: _purchasePriceTEC,
                    hintText: '가격 입력',
                    titleText: '매입 단가 (현재 평단가)',
                    onChangedCB: (newData) {
                      Provider.of<HandleUiDataProvider>(context, listen: false)
                          .changePurchasePriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputTextField(
                    textController: _currentStockPriceTEC,
                    hintText: '개수 입력',
                    titleText: '현재 주가',
                    onChangedCB: (newData) {
                      Provider.of<HandleUiDataProvider>(context, listen: false)
                          .changeCurrentStockPriceData(newData);
                    },
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
