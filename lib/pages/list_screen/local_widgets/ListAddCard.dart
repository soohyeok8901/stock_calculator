import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';

import '../../../constant.dart';

class ListAddCard extends StatelessWidget {
  const ListAddCard({
    Key key,
    this.uiProvider,
    this.carouselController,
  }) : super(key: key);

  final UiDataProvider uiProvider;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('listView에서 카드 추가');
        uiProvider.addCard();
        if (carouselController.ready) {
          carouselController.jumpToPage(uiProvider.stockCardList.length - 2);
        }
      },
      child: Icon(
        Icons.add,
        size: 65.h,
        color: grey,
      ),
    );
  }
}
