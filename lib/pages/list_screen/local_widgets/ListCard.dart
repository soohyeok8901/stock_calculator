import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:stock_calculator/constant.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    this.uiProvider,
    this.index,
  });

  final UiDataProvider uiProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: kListCardDecoration.copyWith(
        color: uiProvider.stockCardList[index].primaryColor,
      ),
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
                    '${uiProvider.stockCardList[index].title} ${uiProvider.stockCardList[index].emoji}',
                    style: TextStyle(fontSize: 23.sp),
                  ),
                ],
              ),
            ),
            Container(
              decoration: kCarouselCardDecoration,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4.h),
                                  child: Text(
                                    '평가금액',
                                    style:
                                        TextStyle(color: grey, fontSize: 12.sp),
                                  ),
                                ),
                                AutoSizeText(
                                  '${uiProvider.stockCardList[index].totalValuationResultText}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                ),
                                AutoSizeText(''),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: Text(
                                  '평가손익',
                                  style:
                                      TextStyle(color: grey, fontSize: 12.sp),
                                ),
                              ),
                              AutoSizeText(
                                '${uiProvider.stockCardList[index].valuationResultText}',
                                style: TextStyle(
                                  color: uiProvider
                                      .stockCardList[index].primaryColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                              AutoSizeText(
                                '${uiProvider.stockCardList[index].valuationLossDiffText}',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: Text(
                                  '수익률',
                                  style:
                                      TextStyle(color: grey, fontSize: 12.sp),
                                ),
                              ),
                              AutoSizeText(
                                '${uiProvider.stockCardList[index].yieldResultText}',
                                style: TextStyle(
                                  color: uiProvider
                                      .stockCardList[index].primaryColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                              AutoSizeText(
                                '${uiProvider.stockCardList[index].yieldDiffText}',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: Text(
                                  '평단가',
                                  style:
                                      TextStyle(color: grey, fontSize: 12.sp),
                                ),
                              ),
                              AutoSizeText(
                                '${uiProvider.stockCardList[index].purchasePriceResultText}',
                                style: TextStyle(
                                  color: uiProvider
                                      .stockCardList[index].primaryColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                              AutoSizeText(
                                '${uiProvider.stockCardList[index].averagePurchaseDiffText}',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
