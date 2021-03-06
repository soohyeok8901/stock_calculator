import 'package:stock_calculator/constant.dart';

import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_widgets/main_screen_widgets.dart';
import './../../utils/utils.dart';
import 'SidebarMenu.dart';

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
  // final TextEditingController _buyPriceTEC = TextEditingController();
  // final TextEditingController _buyQuantityTEC = TextEditingController();
  final TextEditingController _taxTEC = TextEditingController();
  final TextEditingController _tradingFeeTEC = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    _titleTEC.dispose();
    _totalValuationPriceTEC.dispose();
    _holdingQuantityTEC.dispose();
    _purchasePriceTEC.dispose();
    _currentStockPriceTEC.dispose();
    // _buyPriceTEC.dispose();
    // _buyQuantityTEC.dispose();
    _taxTEC.dispose();
    _tradingFeeTEC.dispose();
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
      taxTEC: _taxTEC,
      tradingFeeTEC: _tradingFeeTEC,
    );

    super.initState();
  }

  // ??? ?????? ????????? ??????
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
          key: _scaffoldKey,
          drawer: SideBarMenu(),
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
                              taxTEC: _taxTEC,
                              tradingFeeTEC: _tradingFeeTEC,
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
                                      kMainConatinerPadding, // ????????????????????? ?????? ??????
                                      //*TextFields
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 33.w),
                                            child: Column(
                                              children: [
                                                DividerTitle(
                                                  textString: '?????? ?????? ??????',
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
                                      //TODO: ?????? 4?????? ????????? ????????? ?????? ??? ??? ?????? 2x2 ?????????
                                      //TODO  ????????? ?????? ???????????????.
                                      Padding(
                                        padding: EdgeInsets.only(top: 22.h),
                                        child: Column(
                                          children: [
                                            buildButton(
                                                calcCB: calculateButtonCB,
                                                clearCB: clearButtonCB,
                                                context: context),
                                            SizedBox(height: 30.h),

                                            //TODO: ????????? ????????????????????? ??????
                                            //TODO  ????????? ????????????, ????????? ??????????????? ????????? ???????????????.
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
                        //TODO: ???????????? ????????? ???????????? ??????????????? ???????????????.
                        //TODO  ???????????? '?????????', '?????? ??????', '?????????'??? ?????? ???????????????.
                        //! ??????

                        _scaffoldKey.currentState.openDrawer();
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
                    //     //TODO: ?????? ui??? ????????? ????????? ??? ?????? InkWell ????????? ?????? ???????????????.
                    //     //TODO   ???, $
                    //     //! ??????
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
                      ), //TODO UiProvider?????? ????????? ?????????.
                      onPressed: () {
                        //TODO: uiProvider??? ?????? ?????? ????????? ????????? ?????????????????????
                        //TODO String??? ???????????? ???????????? ???????????????.
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
  //?????????, ?????? ?????? ??????
  Widget buildButton(
      {Function clearCB, Function calcCB, BuildContext context}) {
    return Consumer<UiDataProvider>(
      builder: (_, uiDataProvider, __) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: <Widget>[
              Row(
                //TODO: ????????? ?????? ?????????????????? ?????????????????? (????????? ??????)
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: CustomButton(
                      childTextWidget: kCalculateButtonText,
                      onPressedCB: () {},
                      uiDataProvider: uiDataProvider,
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Expanded(
                    child: CustomButton(
                      childTextWidget: kYieldButtonText,
                      onPressedCB: () {},
                      uiDataProvider: uiDataProvider,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
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
                  SizedBox(width: 30.w),
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

  //?????? ?????? ????????? ??????
  bool _checkValidation() {
    return ((_totalValuationPriceTEC.text.length > 0) &&
        (_holdingQuantityTEC.text.length > 0) &&
        (_purchasePriceTEC.text.length > 0) &&
        (_currentStockPriceTEC.text.length > 0) &&
        (_taxTEC.text.length > 0) &&
        (_tradingFeeTEC.text.length > 0));
  }

  //* TextFields
  ///?????? ????????????, ?????? ????????????[???]
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
                    hintText: '?????? ??????',
                    titleText: '?????? ???????????? (???)',
                    onChangedCB: (newData) {
                      uiDataProvider.changeTotalValuationPriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: InputTextField(
                    textController: _holdingQuantityTEC,
                    hintText: '?????? ??????',
                    titleText: '?????? ???????????? (???)',
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

  /// ????????????, ????????????
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
                    hintText: '?????? ??????',
                    titleText: '?????? ????????? (???)',
                    onChangedCB: (newData) {
                      uiDataProvider.changePurchasePriceData(newData);
                    },
                  ),
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: InputTextField(
                    textController: _currentStockPriceTEC,
                    hintText: '?????? ??????',
                    titleText: '?????? ?????? (???)',
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

  // ????????? ????????????, ?????? ?????? ??????
  Widget buildNewTextFieldColumn(BuildContext context) {
    return Consumer<UiDataProvider>(
      builder: (context, uiDataProvider, widget) {
        return Column(
          children: <Widget>[
            Row(
              //TODO: ?????? ????????????????????? ???????????????, ?????? TEC??? ??????????????????
              children: <Widget>[
                Expanded(
                  child: InputTextField(
                    textController: _tradingFeeTEC,
                    hintText: '??????????????? ??????',
                    titleText: '??????????????? (%)',
                    onChangedCB: (newData) {
                      uiDataProvider.changeTradingFeeData(newData);
                    },
                  ),
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: InputTextField(
                    textController: _taxTEC,
                    hintText: '?????? ??????',
                    titleText: '?????? (%)',
                    onChangedCB: (newData) {
                      uiDataProvider.changeTaxData(newData);
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
