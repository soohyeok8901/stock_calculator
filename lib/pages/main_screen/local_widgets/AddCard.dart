import 'package:stock_calculator/constant.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddCard extends StatelessWidget {
  const AddCard({
    @required this.mainScreenUiCb,
    this.lastIndex,
    this.carouselController,
  });
  final int lastIndex;
  final Function mainScreenUiCb;
  final CarouselController carouselController;
  @override
  Widget build(BuildContext context) {
    return Consumer<UiDataProvider>(
      builder: (context, uiDataProvider, __) {
        return Container(
          width: 500.w,
          margin: EdgeInsets.symmetric(horizontal: 5.0.w),
          decoration: kCarouselCardDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                color: Colors.grey[400],
                height: 50.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Icon(
                  Icons.add,
                  size: 40.sp,
                  color: Colors.white,
                ),
                onPressed: () {
                  Provider.of<UiDataProvider>(context, listen: false).addCard();
                  if (carouselController.ready) {
                    uiDataProvider.setIsLastPage(uiDataProvider.nowPageIndex ==
                        uiDataProvider.stockCardList.length - 1);
                    carouselController.jumpToPage(lastIndex);
                  }
                  mainScreenUiCb();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
