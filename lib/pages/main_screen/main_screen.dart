import 'package:stock_calculator/constant.dart';

import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_widgets/main_screen_widgets.dart';
import './../../utils/utils.dart';

CarouselController carouselController = CarouselController();

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';
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
    initData(
      context: context,
      totalValuationPriceTEC: _totalValuationPriceTEC,
      holdingQuantityTEC: _holdingQuantityTEC,
      purchasePriceTEC: _purchasePriceTEC,
      currentStockPriceTEC: _currentStockPriceTEC,
      buyPriceTEC: _buyPriceTEC,
      buyQuantityTEC: _buyQuantityTEC,
    );

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
      builder: (_, uiDataProvider, calcBrain, __) {
        return Scaffold(
          body: Container(
            decoration: kMainContainerBoxDecoration(uiDataProvider),
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      //*Top Container
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h, top: 60.h),
                        child: CardCarousel(
                          mainScreenUiCb: () {
                            carouselOnPageChangedCb(
                              uiDataProvider: uiDataProvider,
                              titleTEC: _titleTEC,
                              totalValuationPriceTEC: _totalValuationPriceTEC,
                              holdingQuantityTEC: _holdingQuantityTEC,
                              purchasePriceTEC: _purchasePriceTEC,
                              currentStockPriceTEC: _currentStockPriceTEC,
                              buyPriceTEC: _buyPriceTEC,
                              buyQuantityTEC: _buyQuantityTEC,
                            );
                          },
                          initPageNumber: uiDataProvider.nowPageIndex,
                        ),
                      ),

                      //*Main Container
                      Expanded(
                        child: (!uiDataProvider.isLastPage)
                            ? Container(
                                decoration: kMainContainerBorderRadius,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      kMainConatinerPadding, // 메인컨테이너의 전체 패딩
                                      //*TextFields
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.w),
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 9.h,
                                                      ),
                                                      child: kGreyDivider,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        color: Colors.white,
                                                        width: 180.w,
                                                        child: Text(
                                                          '현재 잔고 정보 입력',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[500],
                                                            fontSize: 18.sp,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 6.h),
                                                buildExTextFieldColumn(context),
                                                SizedBox(height: 10.h),
                                                buildExTextFieldColumn2(
                                                    context),
                                                SizedBox(height: 10.h),
                                                buildNewTextFieldColumn(
                                                    context),
                                                SizedBox(height: 10.h),
                                                kGreyDivider,
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      //TODO: 이제 4개의 계산기 기능을 선택 할 수 있는 2x2 행렬의
                                      //TODO  버튼이 있을 예정입니다.
                                      Padding(
                                        padding: EdgeInsets.only(top: 22.h),
                                        child: Column(
                                          children: [
                                            buildButton(
                                                calcCB: calculateButtonCB,
                                                clearCB: clearButtonCB,
                                                context: context),
                                            SizedBox(height: 30.h),

                                            //TODO: 배너는 메인스크린에서 제거
                                            //TODO  계산기 페이지들, 리스트 페이지에서 보여질 예정입니다.
                                            // ShowBannerAd(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                child: WiseSayingGenerator(),
                              ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 4.w,
                    top: 7.h,
                    child: IconButton(
                      iconSize: 30.w,
                      color: Colors.white,
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        //TODO: 슬라이더 메뉴가 왼쪽에서 튀어나도록 수정합시다.
                        //TODO  메뉴에는 '도움말', '카드 목록', '피드백'이 있을 예정입니다.
                        //! 삭제
                        // Navigator.pushNamed(context, ListScreen.id);
                      },
                    ),
                  ),
                  Positioned(
                    right: 4.w,
                    top: 7.h,
                    // child: IconButton(
                    //   iconSize: 30.w,
                    //   color: Colors.white,
                    //   icon: Icon(Icons.help_outline_rounded),
                    //   onPressed: () {
                    //     //TODO: 카드 ui의 통화를 변경할 수 있는 InkWell 버튼이 있을 예정입니다.
                    //     //TODO   ₩, $
                    //     //! 삭제
                    //     // Navigator.pushNamed(context, HelpScreen.id);
                    //   },
                    // ),
                    child: MaterialButton(
                      minWidth: 3.w,
                      height: 10.h,
                      child: Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ), //TODO UiProvider에서 가지고 옵시다.
                      onPressed: () {
                        //TODO: uiProvider에 해당 기호 다루는 메서드 생성해야겠군요
                        //TODO String을 리턴해서 관리하면 되겠습니다.
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //*UI generator
  //초기화, 계산 버튼 생성
  Widget buildButton(
      {Function clearCB, Function calcCB, BuildContext context}) {
    return Consumer<UiDataProvider>(
      builder: (_, uiDataProvider, __) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: <Widget>[
              Row(
                //TODO: 버튼에 맞는 네비게이션을 달아야합니다 (계산기 기능)
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: CustomButton(
                      childTextWidget: kCalculateButtonText,
                      onPressedCB: () {},
                      uiDataProvider: uiDataProvider,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: CustomButton(
                      childTextWidget: kYieldButtonText,
                      onPressedCB: () {},
                      uiDataProvider: uiDataProvider,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: CustomButton(
                      childTextWidget: kAccumulateButtonText,
                      onPressedCB: () {},
                      uiDataProvider: uiDataProvider,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: CustomButton(
                      childTextWidget: kDistributeButtonText,
                      onPressedCB: () {},
                      uiDataProvider: uiDataProvider,
                    ),
                  ),
                ],
              )
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

  //* TextFields
  ///현재 평가금액, 현재 보유수량[주]
  Widget buildExTextFieldColumn(BuildContext context) {
    return Consumer<UiDataProvider>(
      builder: (context, uiDataProvider, __) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: _totalValuationPriceTEC,
                    hintText: '가격 입력',
                    titleText: '현재 평가금액 (원)',
                    onChangedCB: (newData) {
                      uiDataProvider.changeTotalValuationPriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 23.w),
                Expanded(
                  child: InputTextField(
                    textController: _holdingQuantityTEC,
                    hintText: '개수 입력',
                    titleText: '현재 보유수량 (주)',
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
      builder: (context, uiDataProvider, __) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: _purchasePriceTEC,
                    hintText: '가격 입력',
                    titleText: '현재 평단가 (원)',
                    onChangedCB: (newData) {
                      uiDataProvider.changePurchasePriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 23.w),
                Expanded(
                  child: InputTextField(
                    textController: _currentStockPriceTEC,
                    hintText: '가격 입력',
                    titleText: '현재 주가 (원)',
                    onChangedCB: (newData) {
                      uiDataProvider.changeCurrentStockPriceData(newData);
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
      builder: (context, uiDataProvider, widget) {
        return Column(
          children: <Widget>[
            Row(
              //TODO: 전부 수정해야합니다 매매수수료, 세금 TEC도 수정해야해요
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: _buyPriceTEC,
                    hintText: '매매수수료 입력',
                    titleText: '매매수수료 (%)',
                    onChangedCB: (newData) {
                      uiDataProvider.changeBuyPriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 23.w),
                Expanded(
                  child: InputTextField(
                    textController: _buyQuantityTEC,
                    hintText: '세금 입력',
                    titleText: '세금 (%)',
                    onChangedCB: (newData) {
                      uiDataProvider.changeBuyQuantityData(newData);
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
