import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/widgets/banner_ad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color green = Color(0xFF44D375);
  Color weakGreen = Color(0xFFf3ffed);
  Color red = Color(0xFFDF4053);
  Color weakRed = Color(0xFFF5E1DD);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _existingStocksPriceTEC = TextEditingController();
  final TextEditingController _existingStocksCountTEC = TextEditingController();
  final TextEditingController _newStocksPriceTEC = TextEditingController();
  final TextEditingController _newStocksCountTEC = TextEditingController();

  bool _toggleExchange = false;

  @override
  void dispose() {
    _existingStocksPriceTEC.dispose();
    _existingStocksCountTEC.dispose();
    _newStocksPriceTEC.dispose();
    _newStocksCountTEC.dispose();
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
      backgroundColor: red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Expanded(
              child: Text(
                "평균단가 계산기",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(19),
                  topLeft: Radius.circular(19),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 210,
                            child: SwitchListTile(
                              title: Text(
                                '달러로 보기 (\$)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              ),
                              value: _toggleExchange,
                              contentPadding: EdgeInsets.only(left: 40),
                              onChanged: (value) {
                                setState(() => _toggleExchange = value);
                              },
                              activeColor: green,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 80,
                          top: 30,
                          bottom: 30,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _existingStocksPriceTEC,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return '현재 평균단가를 입력하세요';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: '현재 평균단가',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _existingStocksCountTEC,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return '현재 보유중인 개수를 입력하세요';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: '현재 보유개수',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _newStocksPriceTEC,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return '추가 매수할 주식의 단가를 입력하세요';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: '추가 매수할 주식의 단가',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _newStocksCountTEC,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return '추가로 매수할 수량을 입력하세요';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: '추가 매수 수량',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //TextAniamtion
                      Text(
                        Provider.of<CalcBrain>(context).calcResult,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MaterialButton(
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
                                _existingStocksCountTEC.clear();
                                _existingStocksPriceTEC.clear();
                                _newStocksCountTEC.clear();
                                _newStocksPriceTEC.clear();
                              });
                              Provider.of<CalcBrain>(context, listen: false)
                                  .clearPrice();
                            },
                          ),
                          MaterialButton(
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
                              Provider.of<CalcBrain>(context, listen: false)
                                  .calcAverage(
                                      exSCount: int.parse(
                                          _existingStocksCountTEC.text),
                                      exSPrice: double.parse(
                                          _existingStocksPriceTEC.text),
                                      newSCount:
                                          int.parse(_newStocksCountTEC.text),
                                      newSPrice: double.parse(
                                          _newStocksPriceTEC.text));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  ShowBannerAd(),
                ],
              ),
            ),
          ),
        ],
      ),
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
