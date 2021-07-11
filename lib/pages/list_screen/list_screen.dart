import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_calculator/provider/cardCarousel_provider.dart';
import 'package:stock_calculator/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/utils/string_func.dart';

import 'local_widgets/list_screen_widgets.dart';

import '../../constant.dart';

class ListScreen extends StatelessWidget {
  static String id = 'list_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiDataProvider, CardCarouselProvider>(
      builder: (context, uiProvider, cardCarouselProvider, widget) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                (Provider.of<UiDataProvider>(context).primaryColor == grey)
                    ? grey
                    : (Provider.of<UiDataProvider>(context).primaryColor == red)
                        ? buttonRed
                        : buttonBlue,
            title: Padding(
              padding: EdgeInsets.only(left: 67.w),
              child: Text(
                '계산기 목록 🔎',
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 13.w, right: 13.w),
                  child: AutoSizeText(
                    '총 평가 금액: ${currencyFormat(uiProvider.calculateTotalValuationSum())} 원',
                    style: TextStyle(
                      fontSize: 30.sp,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Expanded(
                flex: 10,
                child: SizedBox(
                  width: INF,
                  height: 800.h,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (!uiProvider.stockCardList[index].isEnd) {
                        return InkWell(
                          onTap: () {
                            print(
                                '${uiProvider.stockCardList[index].title} 클릭');
                            Navigator.pop(context);
                            if (cardCarouselProvider.carouselController.ready) {
                              cardCarouselProvider.carouselController
                                  .jumpToPage(index);
                            }
                          },
                          child: ListCard(
                            uiProvider: uiProvider,
                            index: index,
                            lastPageIndex: uiProvider.nowPageIndex,
                            carouselController:
                                cardCarouselProvider.carouselController,
                          ),
                        );
                      } else {
                        return ListAddCard(
                          uiProvider: uiProvider,
                          carouselController:
                              cardCarouselProvider.carouselController,
                        );
                      }
                    },
                    itemCount: uiProvider.stockCardList.length,
                    separatorBuilder: (context, index) => SizedBox(height: 0.h),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
