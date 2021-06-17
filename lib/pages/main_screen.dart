import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/widgets/CardCarousel.dart';
import 'package:averge_price_calc/widgets/InputTextField.dart';
import 'package:averge_price_calc/widgets/TitleTextField.dart';
import 'package:averge_price_calc/widgets/banner_ad.dart';
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

  @override
  void dispose() {
    _exStockPriceController.dispose();
    _exStockCountController.dispose();
    _newStockPriceController.dispose();
    _newStockCountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: Shared preference 쓰면 되겠죠? 확인 후 필요없으면 삭제
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    '😢 😥😰',
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
                        titleTextController: _titleTextContorller,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                buildExTextFieldColumn(),
                                SizedBox(height: 10),
                                buildNewTextFieldColumn(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14.0),
                        child: Column(
                          children: [
                            buildCalculator(context),
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
  }

  Padding buildCalculator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Provider.of<CalcBrain>(context).calcResult ?? '0 원',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '(${Provider.of<CalcBrain>(context).priceDiff})' ?? '',
                style: TextStyle(
                  fontSize: 17,
                  textBaseline: TextBaseline.alphabetic,
                  fontWeight: FontWeight.bold,
                  color: Provider.of<CalcBrain>(context).priceDiff[0] == '-'
                      ? Colors.indigoAccent[700]
                      : Colors.red,
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
                  onPressed: () {
                    setState(() {
                      _exStockCountController.clear();
                      _exStockPriceController.clear();
                      _newStockCountController.clear();
                      _newStockPriceController.clear();
                    });
                    Provider.of<CalcBrain>(context, listen: false).clearPrice();
                  },
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
                  onPressed: () {
                    Provider.of<CalcBrain>(context, listen: false).calcAverage(
                        exSCount: int.parse(_exStockCountController.text),
                        exSPrice: double.parse(_exStockPriceController.text),
                        newSCount: int.parse(_newStockCountController.text),
                        newSPrice: double.parse(_newStockPriceController.text));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildNewTextFieldColumn() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: InputTextField(
                textController: _newStockPriceController,
                hintText: '가격 입력',
                titleText: '구매할 주식의 가격',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: InputTextField(
                textController: _newStockCountController,
                hintText: '개수 입력',
                titleText: '구매할 주식수[주]',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildExTextFieldColumn() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: InputTextField(
                textController: _exStockPriceController,
                hintText: '가격 입력',
                titleText: '보유 평균단가',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: InputTextField(
                textController: _exStockCountController,
                hintText: '개수 입력',
                titleText: '보유 수량[주]',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
