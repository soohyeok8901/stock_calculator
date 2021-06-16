import 'package:averge_price_calc/models/calculator.dart';
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
            Container(
              height: 170,
              child: FlutterLogo(
                size: 400,
              ),
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
              Text(
                Provider.of<CalcBrain>(context).priceDiff ?? '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
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

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    @required this.titleTextController,
  });

  final TextEditingController titleTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
      child: TextField(
        controller: titleTextController,
        decoration: InputDecoration(
          hintText: '타이틀',
        ),
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23),
        maxLength: 12,
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  InputTextField({
    @required this.textController,
    @required this.titleText,
    @required this.hintText,
  });

  final TextEditingController textController;
  final String titleText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          titleText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 43,
          width: 200,
          child: TextField(
            controller: textController,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
// padding: EdgeInsets.only(
//   right: 100,
//   top: 30,
//   left: 30,
// ),

//TODO: Column 비율 조절, switchTile을 그냥 switch + Text로 변경, textFormField 사이즈 변경
//TODO: 버튼만들기,
//TODO: UI 이쁘게 다듬기
//TODO: 서버연동 환율 API 다루는 노드서버만들어야겠네
