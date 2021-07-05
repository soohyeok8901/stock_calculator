import 'package:averge_price_calc/models/calculator.dart';
import 'package:averge_price_calc/widgets/CardCarousel.dart';
import 'package:averge_price_calc/widgets/InputTextField.dart';
import 'package:averge_price_calc/widgets/TitleTextField.dart';
import 'package:averge_price_calc/widgets/banner_ad.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

// TODO: 리팩토링

CarouselController carouselController = CarouselController();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
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
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void initState() {
    //LifeCycleWatcher init
    WidgetsBinding.instance.addObserver(this);

    //shared_preferences init
    _initData();
    //TODO: 디자인 반응형으로 만들기
    //TODO: 이건 실기기 테스트도 같이해야하는데
    //TODO: 잠시 핫스팟좀 틀어달라고 해야겠네요.

    super.initState();
  }

  // 앱 상태 변경시 호출
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed");
        break;
      case AppLifecycleState.inactive:
        Provider.of<UiDataProvider>(context, listen: false).saveData();
        print("inactive");
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiDataProvider, CalcBrain>(
      builder: (context, handleUiDataProvider, calcBrain, widget) {
        /////////////////////////button callbacks
        Function calculateButtonCB = () {
          handleUiDataProvider.tabCalculateButton(context);

          //shared_preferences textfield 데이터 저장
          _setTextFieldData();

          //shared_preferences 내부 데이터들(중간계산, 결과값 등) 저장
          _setInnerData(context);

          //컴마 살균
          _sanitizingComma(calcBrain);

          //stockCardList[nowPageIndex]에 데이터들 set
          handleUiDataProvider.setData();
        };

        Function clearButtonCB = () {
          handleUiDataProvider.tabClearButton(context);
          //텍스트필드 clear
          _clearTextField();

          //shared_preferences textfield 데이터 저장
          _setTextFieldData();

          //shared_preferences 내부 데이터들(중간계산, 결과값 등) 저장
          _setInnerDataForClear(context);
        };

        Function carouselOnPageChangedCb = () {
          _titleTEC.text = handleUiDataProvider.title;
          _totalValuationPriceTEC.text =
              handleUiDataProvider.totalValuationPrice.toString();
          _holdingQuantityTEC.text =
              handleUiDataProvider.holdingQuantity.toString();
          _purchasePriceTEC.text =
              handleUiDataProvider.purchasePrice.toString();
          _currentStockPriceTEC.text =
              handleUiDataProvider.currentStockPrice.toString();
          _buyPriceTEC.text = handleUiDataProvider.buyPrice.toString();
          _buyQuantityTEC.text = handleUiDataProvider.buyQuantity.toString();
        };

        return Scaffold(
          backgroundColor: handleUiDataProvider.primaryColor,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                //////////////////////Top Container
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    // transform: Transform(transform: ,),
                    child: Text(
                      handleUiDataProvider.emoji,
                      style: kEmojiTextStyle,
                      textAlign: kTextAlignCenter,
                    ),
                    // decoration: kEmojiContainerBoxDecoration,
                    // padding: EdgeInsets.all(2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 5),
                  child: CardCarousel(
                    mainScreenUiCb: carouselOnPageChangedCb,
                    initPageNumber: handleUiDataProvider.nowPageIndex,
                  ),
                ),

                //////////////////////Main Container
                Expanded(
                  child: Container(
                    decoration: kMainContainerBorderRadius,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          /////////////////////////TitleTextField
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                            //TODO: 여기에 타이틀이 들어가야겠죠? 잘 해봅시다.. 화이팅...!
                            child: TitleTextField(
                              context: context,
                              titleTextController: _titleTEC,
                              onChangedCB: (newData) {
                                handleUiDataProvider.changeTitleData(newData);
                              },
                              onPressedCB: () {
                                //해당 pageIndex의 stock_card데이터의 title데이터 수정해야함.
                              },
                            ),
                          ),
                          /////////////////////////TextFields
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
                                    kGreyDivider,
                                    SizedBox(height: 5),
                                    buildNewTextFieldColumn(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /////////////////////////resultBox, banner
                          Padding(
                            padding: EdgeInsets.only(top: 14.0),
                            child: Column(
                              children: [
                                //resultBox

                                // buildResultBox(
                                //     context, calculateButtonCB, clearButtonCB),
                                buildButton(
                                    calcCB: calculateButtonCB,
                                    clearCB: clearButtonCB,
                                    context: context),
                                SizedBox(height: 10),
                                //배너
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

  ///                             Shared_preferences
  //앱 실행 시, 저장돼있던 Data들을 불러옵니다.
  void _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //TextField의 텍스트 로딩
    _loadTextFieldData(prefs);

    //내부 데이터들(중간계산, 결과값 등) 로딩
    _loadInnerData();
  }

  //앱 실행 시, 저장돼있던 ui_data_provider 데이터들을 불러옵니다.
  void _loadInnerData() {
    Provider.of<UiDataProvider>(context, listen: false).loadData();
  }

  //앱 실행 시, 저장돼있던 TextField input값들을 불러옵니다.
  void _loadTextFieldData(SharedPreferences prefs) {
    _totalValuationPriceTEC.text =
        prefs.getString('totalValuationPriceTF') ?? '';
    _holdingQuantityTEC.text = prefs.getString('holdingQuantityTF') ?? '';
    _purchasePriceTEC.text = prefs.getString('purchasePriceTF') ?? '';
    _currentStockPriceTEC.text = prefs.getString('currentStockPriceTF') ?? '';
    _buyPriceTEC.text = prefs.getString('buyPriceTF') ?? '';
    _buyQuantityTEC.text = prefs.getString('buyQuantityTF') ?? '';
  }

  // 계산 버튼을 누르면 TextField input값들을 저장합니다.
  void _setTextFieldData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalValuationPriceTF', _totalValuationPriceTEC.text);
    prefs.setString('holdingQuantityTF', _holdingQuantityTEC.text);
    prefs.setString('purchasePriceTF', _purchasePriceTEC.text);
    prefs.setString('currentStockPriceTF', _currentStockPriceTEC.text);
    prefs.setString('buyPriceTF', _buyPriceTEC.text);
    prefs.setString('buyQuantityTF', _buyQuantityTEC.text);
  }

  //클리어버튼 눌렀을 때 데이터 초기화된 채로 저장
  void _setInnerDataForClear(BuildContext context) {
    Provider.of<UiDataProvider>(context, listen: false).saveDataForClear();
  }

  void _setInnerData(BuildContext context) {
    Provider.of<UiDataProvider>(context, listen: false).saveData();
  }

  ///
  ///
  ///
  ///
  ///
  ///
  //////////////////////////////UI methods

  // 텍스트 필드 clears
  void _clearTextField() {
    _totalValuationPriceTEC.clear();
    _holdingQuantityTEC.clear();
    _purchasePriceTEC.clear();
    _currentStockPriceTEC.clear();
    _buyPriceTEC.clear();
    _buyQuantityTEC.clear();
  }

  //컴마, -, 온점 살균
  void _sanitizingComma(CalcBrain calcBrain) {
    _totalValuationPriceTEC.text =
        calcBrain.sanitizeComma(_totalValuationPriceTEC.text).toString();
    _holdingQuantityTEC.text =
        calcBrain.sanitizeComma(_holdingQuantityTEC.text).toString();
    _purchasePriceTEC.text =
        calcBrain.sanitizeComma(_purchasePriceTEC.text).toString();
    _currentStockPriceTEC.text =
        calcBrain.sanitizeComma(_currentStockPriceTEC.text).toString();
    _buyPriceTEC.text = calcBrain.sanitizeComma(_buyPriceTEC.text).toString();
    _buyQuantityTEC.text =
        calcBrain.sanitizeComma(_buyQuantityTEC.text).toString();
  }

  //계산 결과 박스 생성
  Widget buildResultBox(
      BuildContext context, Function calcCB, Function clearCB) {
    return Consumer2<UiDataProvider, CalcBrain>(
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
                  /////////////////////평가총액
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      /////평가총액 타이틀
                      Expanded(
                        flex: 3,
                        child: kTotalValuationTitle,
                      ),
                      SizedBox(width: 15),

                      //계산된 평가총액
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          handleUiDataProvider.totalValuationResultText ??
                              '0 원',
                          style: kTotalValuationTextStyle,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 15),

                      //계산된 평가손익
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
                  /////////////////////수익률
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //수익률 타이틀
                      Expanded(
                        flex: 3,
                        child: kYieldTitle,
                      ),
                      SizedBox(width: 10),

                      //계산된 수익률
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

                      //계산된 수익률 차이
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

                  /////////////////////평단가
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //평단가 타이틀
                      Expanded(
                        flex: 3,
                        child: kPurchasePriceTitle,
                      ),
                      SizedBox(width: 10),

                      //계산된 평단가
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

                      //계산된 평단가 차이
                      Expanded(
                        flex: 4,
                        // child: Container(),
                        child: AutoSizeText(
                          handleUiDataProvider.averagePurchaseDiffText ?? '',
                          style: kAveragePurchaseDiffTextStyle,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  //초기화, 계산 버튼 생성
  Widget buildButton(
      {Function clearCB, Function calcCB, BuildContext context}) {
    return Consumer<UiDataProvider>(
      builder: (_, handleUiDataProvider, __) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  minWidth: 30,
                  height: 30,
                  color: handleUiDataProvider.primaryColor,
                  child: kClearButtonText,
                  onPressed: clearCB,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: MaterialButton(
                  minWidth: 30,
                  height: 30,
                  color: handleUiDataProvider.primaryColor,
                  child: kCalculateButtonText,
                  onPressed: _checkValidation() ? calcCB : null,
                  disabledColor: Colors.grey[800],
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //계산 버튼 활성화 조건
  bool _checkValidation() {
    return ((_totalValuationPriceTEC.text.length > 0) &&
        (_holdingQuantityTEC.text.length > 0) &&
        (_purchasePriceTEC.text.length > 0) &&
        (_currentStockPriceTEC.text.length > 0) &&
        (_buyPriceTEC.text.length > 0) &&
        (_buyQuantityTEC.text.length > 0));
  }

  ///////////////////////////////TextFields
  ///현재 평가금액, 현재 보유수량[주]
  Widget buildExTextFieldColumn(BuildContext context) {
    return Consumer<UiDataProvider>(
      builder: (context, handleUiDataProvider, __) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: _totalValuationPriceTEC,
                    hintText: '가격 입력',
                    titleText: '현재 평가금액 (평가손익 X)',
                    onChangedCB: (newData) {
                      Provider.of<UiDataProvider>(context, listen: false)
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
                      Provider.of<UiDataProvider>(context, listen: false)
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

  /// 매입단가, 현재주가
  Widget buildExTextFieldColumn2(BuildContext context) {
    return Consumer<UiDataProvider>(
      builder: (context, handleUiDataProvider, __) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: _purchasePriceTEC,
                    hintText: '가격 입력',
                    titleText: '현재 매입단가 (평단가)',
                    onChangedCB: (newData) {
                      Provider.of<UiDataProvider>(context, listen: false)
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
                      Provider.of<UiDataProvider>(context, listen: false)
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

  // 미래의 예상주가, 예상 구매 수량
  Widget buildNewTextFieldColumn(BuildContext context) {
    return Consumer<UiDataProvider>(
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
                      Provider.of<UiDataProvider>(context, listen: false)
                          .changeBuyPriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputTextField(
                    textController: _buyQuantityTEC,
                    hintText: '개수 입력',
                    titleText: '구매수량[주] (0주 가능)',
                    onChangedCB: (newData) {
                      Provider.of<UiDataProvider>(context, listen: false)
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
}
