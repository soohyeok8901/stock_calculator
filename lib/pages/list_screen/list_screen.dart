import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_calculator/provider/cardCarousel_provider.dart';
import 'package:stock_calculator/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          body: ListView.separated(
            itemBuilder: (context, index) {
              if (!uiProvider.stockCardList[index].isEnd) {
                return InkWell(
                  onTap: () {
                    print('${uiProvider.stockCardList[index].title} 클릭');
                    Navigator.pop(context);
                    if (cardCarouselProvider.carouselController.ready) {
                      cardCarouselProvider.carouselController.jumpToPage(index);
                    }
                  },
                  child: ListCard(
                    uiProvider: uiProvider,
                    index: index,
                  ),
                );
              } else {
                return ListAddCard(uiProvider: uiProvider);
              }
            },
            itemCount: uiProvider.stockCardList.length,
            separatorBuilder: (context, index) => SizedBox(height: 0.h),
          ),
        );
      },
    );
  }
}
