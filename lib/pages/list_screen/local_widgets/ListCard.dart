import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:stock_calculator/constant.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    this.uiProvider,
    this.index,
    this.lastPageIndex,
    this.carouselController,
  });
  final CarouselController carouselController;
  final UiDataProvider uiProvider;
  final int index;
  final int lastPageIndex;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.18.w,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          child: Container(
            height: 55.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    '${uiProvider.stockCardList[index].emoji}',
                    style: TextStyle(fontSize: 23.sp),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    width: 10.w,
                    child: AutoSizeText(
                      '${uiProvider.stockCardList[index].title}',
                      style: TextStyle(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    // width: 390.w,
                    // height: 111.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AutoSizeText(
                          '${uiProvider.stockCardList[index].totalValuationResultText}',
                          style: TextStyle(
                            fontSize: 21.sp,
                          ),
                        ),
                        AutoSizeText(
                          '${uiProvider.stockCardList[index].valuationResultText} (${uiProvider.stockCardList[index].yieldResultText})',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: uiProvider.stockCardList[index].primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '삭제',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            uiProvider.deleteCard(index: index);
            if (carouselController.ready) {
              carouselController
                  .jumpToPage(uiProvider.stockCardList.length - 2);
            }
          },
        ),
      ],
    );
  }
}
