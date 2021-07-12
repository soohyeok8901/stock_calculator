import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/models/stock_card.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:stock_calculator/constant.dart';

enum Currency { WON, DOLLER, COIN }

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    Key key,
    @required TextEditingController titleTextController,
    @required TextEditingController taxTextController,
    @required TextEditingController tradingFeeTextController,
    @required TextEditingController exRateTextController,
    @required this.cardData,
    @required this.index,
    @required this.carouselController,
  })  : _titleTextController = titleTextController,
        _taxTextController = taxTextController,
        _tradingFeeTextController = tradingFeeTextController,
        _exRateTextController = exRateTextController;

  final StockCard cardData;
  final TextEditingController _titleTextController;
  final TextEditingController _taxTextController;
  final TextEditingController _tradingFeeTextController;
  final TextEditingController _exRateTextController;
  final int index;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    Currency _currency = Currency.WON;
    _exRateTextController.text = cardData.exchangeRate.toString() ?? '500';
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
      ),
      onSelected: (value) async {
        if (value == '이름변경') {
          print('이름변경 선택');
          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        '이름 변경  ✏️',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    content: SizedBox(
                      width: 500.w,
                      height: 150.h,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.h),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                Provider.of<UiDataProvider>(context,
                                        listen: false)
                                    .changeTitleData(_titleTextController.text);
                              });
                            },
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            controller: _titleTextController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.h,
                                horizontal: 15.w,
                              ),
                              hintText: "계산기 별명",
                            ),
                            maxLength: 10,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                height: 30.h,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.white,
                                focusColor: Colors.black,
                                disabledColor: grey,
                                disabledTextColor: Colors.white,
                                child: Text(
                                  "수정하기",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_titleTextController.text.length > 0) {
                                    setState(() {
                                      Provider.of<UiDataProvider>(context,
                                              listen: false)
                                          .setTitle();
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (value == '통화설정') {
          print('통화설정 선택');
          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        '통화 설정  ✏️',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    content: SizedBox(
                      width: 500.w,
                      height: 350.h,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 200.w,
                            height: 200.h,
                            child: Column(
                              children: <Widget>[
                                RadioListTile(
                                  title: Text('원'),
                                  value: Currency.WON,
                                  groupValue: _currency,
                                  onChanged: (value) {
                                    setState(() {
                                      _currency = value;
                                      // _exRateTextController.text = '';
                                    });
                                    Provider.of<UiDataProvider>(context,
                                            listen: false)
                                        .setCurrency(
                                      currency: '원',
                                    );
                                  },
                                ),
                                RadioListTile(
                                  title: Text('달러 USD/KRW'),
                                  value: Currency.DOLLER,
                                  groupValue: _currency,
                                  onChanged: (value) {
                                    print(cardData.exchangeRate);

                                    setState(() {
                                      _currency = value;
                                      _exRateTextController.text =
                                          cardData.exchangeRate ?? '1130';
                                    });
                                    Provider.of<UiDataProvider>(context,
                                            listen: false)
                                        .setCurrency(
                                      currency: '달러',
                                    );
                                  },
                                ),
                                RadioListTile(
                                  title: Text('코인 COIN/KRW'),
                                  value: Currency.COIN,
                                  groupValue: _currency,
                                  onChanged: (value) {
                                    print(cardData.exchangeRate);
                                    setState(() {
                                      _currency = value;
                                      _exRateTextController.text =
                                          cardData.exchangeRate.toString() ??
                                              '500';
                                    });

                                    Provider.of<UiDataProvider>(context,
                                            listen: false)
                                        .setCurrency(
                                      currency: '코인',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 10.h),
                          (_currency != Currency.WON)
                              ? Text(
                                  '환율',
                                  style: kInputTextFieldTitleTextStyle,
                                )
                              : Text(''),
                          SizedBox(height: 8.h),
                          Container(
                            height: 28.h,
                            width: 170.w,
                            child: (_currency != Currency.WON)
                                ? TextField(
                                    controller: _exRateTextController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: '환율',
                                      enabledBorder:
                                          kInputTextFieldEnableBorder,
                                      focusedBorder:
                                          kInputTextFieldFocusedBorder,
                                    ),
                                    keyboardType: TextInputType.number,
                                  )
                                : null,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                height: 30.h,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.white,
                                focusColor: Colors.black,
                                disabledColor: grey,
                                disabledTextColor: Colors.white,
                                child: Text(
                                  "적용하기",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_currency == Currency.WON) {
                                    Navigator.pop(context);
                                  } else {
                                    if (_titleTextController.text.length > 0) {
                                      try {
                                        setState(() {
                                          Provider.of<UiDataProvider>(context,
                                                  listen: false)
                                              .setExRate(
                                            exRate: double.parse(
                                                _exRateTextController.text),
                                          );
                                          Navigator.pop(context);
                                        });
                                      } catch (e) {}
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (value == '수수료설정') {
          print('수수료설정 선택');
          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        '수수료/세금 설정  ✏️',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    content: SizedBox(
                      width: 500.w,
                      height: 180.h,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '매매수수료 (%)',
                            style: kInputTextFieldTitleTextStyle,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            height: 28.h,
                            width: 170.w,
                            child: TextField(
                              controller: _tradingFeeTextController,

                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                hintText: '매매수수료',
                                enabledBorder: kInputTextFieldEnableBorder,
                                focusedBorder: kInputTextFieldFocusedBorder,
                              ),
                              // onChanged: onChangedCB,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '세금 (%)',
                            style: kInputTextFieldTitleTextStyle,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            height: 28.h,
                            width: 170.w,
                            child: TextField(
                              controller: _taxTextController,

                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                hintText: '세금',
                                enabledBorder: kInputTextFieldEnableBorder,
                                focusedBorder: kInputTextFieldFocusedBorder,
                              ),
                              // onChanged: onChangedCB,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                height: 30.h,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.white,
                                focusColor: Colors.black,
                                disabledColor: grey,
                                disabledTextColor: Colors.white,
                                child: Text(
                                  "수정하기",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_titleTextController.text.length > 0) {
                                    setState(() {
                                      try {
                                        Provider.of<UiDataProvider>(context,
                                                listen: false)
                                            .setTaxTradingFee(
                                                tax: double.parse(
                                                    _taxTextController.text),
                                                tradingFee: double.parse(
                                                    _tradingFeeTextController
                                                        .text));
                                        Navigator.pop(context);
                                      } catch (e) {
                                        print(e);
                                      }
                                    });
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (value == '삭제') {
          print('삭제 선택');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  '삭제하시겠습니까?  ⚠️',
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 30.w,
                      height: 30.h,
                      // color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[500]),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('아니오'),
                    ),
                    SizedBox(width: 10.w),
                    MaterialButton(
                      minWidth: 30.w,
                      height: 30.h,
                      // color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[500]),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () {
                        Provider.of<UiDataProvider>(context, listen: false)
                            .deleteCard(index: index);
                        if (carouselController.ready) {
                          carouselController.jumpToPage(index - 1);
                        }
                        Navigator.pop(context);
                      },
                      child: Text('예'),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          print('뭐야');
        }
      },
      shape: Border.all(),
      itemBuilder: (context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            value: "이름변경",
            height: 23.h,
            child: Text(
              '이름변경',
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
          PopupMenuDivider(height: 23.h),
          PopupMenuItem(
            value: "수수료설정",
            height: 23.h,
            child: Text(
              '수수료/세금 설정',
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
          PopupMenuDivider(height: 23.h),
          PopupMenuItem(
            value: "통화설정",
            height: 23.h,
            child: Text(
              '통화 설정',
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
          (index != 0) ? PopupMenuDivider(height: 23.h) : null,
          (index != 0)
              ? PopupMenuItem(
                  value: "삭제",
                  height: 23.h,
                  child: Text(
                    '삭제',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                )
              : null,
        ];
      },
    );
  }
}
