import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_calculator/constant.dart';
import 'package:stock_calculator/models/stock_card.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'PopupMenu.dart';

class MainCard extends StatelessWidget {
  MainCard({
    Key key,
    @required this.cardData,
    this.index,
    this.carouselController,
  }) : super(key: key);
  final int index;
  final StockCard cardData;
  final CarouselController carouselController;
  final TextEditingController _titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleTextController.text = cardData.title;
    return Stack(
      children: <Widget>[
        Container(
          width: 500.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: kCarouselCardDecoration,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //              카드 생성 파트
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 7.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        '${cardData.title}',
                        style: TextStyle(
                            fontSize: 23.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 64.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                '평가금액',
                                style: TextStyle(color: grey, fontSize: 12.sp),
                              ),
                            ),
                            AutoSizeText(
                              '${cardData.totalValuationResultText}',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AutoSizeText(''),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 64.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                '평가손익',
                                style: TextStyle(color: grey, fontSize: 12.sp),
                              ),
                            ),
                            AutoSizeText(
                              '${cardData.valuationResultText}',
                              style: TextStyle(
                                color: cardData.primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            AutoSizeText(
                              '${cardData.valuationLossDiffText}',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 64.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                '수익률',
                                style: TextStyle(color: grey, fontSize: 12.sp),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            AutoSizeText(
                              '${cardData.yieldResultText}',
                              style: TextStyle(
                                color: cardData.primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            AutoSizeText(
                              '${cardData.yieldDiffText}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 64.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                '평단가',
                                style: TextStyle(color: grey, fontSize: 12.sp),
                              ),
                            ),
                            AutoSizeText(
                              '${cardData.purchasePriceResultText}',
                              style: TextStyle(
                                color: cardData.primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            AutoSizeText(
                              '${cardData.averagePurchaseDiffText}',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 262.w,
          child: PopupMenu(
            titleTextController: _titleTextController,
            index: index,
            carouselController: carouselController,
          ),
        ),
      ],
    );
  }
}
