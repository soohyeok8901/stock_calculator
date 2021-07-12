import 'package:stock_calculator/models/stock_card.dart';
import 'package:stock_calculator/provider/cardCarousel_provider.dart';
import 'package:stock_calculator/provider/providers.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../main_screen.dart';
import 'AddCard.dart';
import 'MainCard.dart';

final CarouselController carouselController = CarouselController();
bool isLoaded = false;

class CardCarousel extends StatefulWidget {
  CardCarousel({this.mainScreenUiCb, this.initPageNumber});

  final Function mainScreenUiCb;
  final int initPageNumber;

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  Function cb;
  int initPageNumber;
  @override
  void initState() {
    super.initState();
    cb = widget.mainScreenUiCb;
    initPageNumber = widget.initPageNumber;
  }

  @override
  Widget build(BuildContext context) {
    _initStartCard(
        Provider.of<CardCarouselProvider>(context).carouselController);

    return Column(
      children: [
        Consumer3<UiDataProvider, TitleWidgetProvider, CardCarouselProvider>(
          builder: (context, uiProvider, titleProvider, cardCarouselProvider,
              widget) {
            return CarouselSlider.builder(
              itemCount: uiProvider.stockCardList.length,
              carouselController: cardCarouselProvider.carouselController,
              options: CarouselOptions(
                height: 218.h,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                // initialPage: widget.initPageNumber,
                onPageChanged: (index, reason) {
                  uiProvider.nowPageIndex = index;
                  uiProvider.loadUiByChangedPage(
                      index: index); //ui_data_provider.dart data 갱신
                  cb(); // main_screen.dart textField 갱신
                  _checkPageIndex(uiProvider); // Main Container 조건부 렌더링용
                  titleProvider.setFalse();
                  FocusScope.of(context)
                      .requestFocus(FocusNode()); //스와이프 시, FN unfocus
                },
              ),
              itemBuilder: (context, index, _) {
                StockCard cardData = uiProvider.stockCardList[index];
                if (uiProvider.stockCardList[index].isEnd) {
                  return AddCard(
                    mainScreenUiCb: cb,
                    lastIndex: uiProvider.stockCardList.length - 1,
                    carouselController: cardCarouselProvider.carouselController,
                  );
                } else {
                  return MainCard(
                    cardData: cardData,
                    index: index,
                    carouselController: cardCarouselProvider.carouselController,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _checkPageIndex(UiDataProvider uiProvider) {
    uiProvider.setIsLastPage(
        uiProvider.nowPageIndex == uiProvider.stockCardList.length - 1);
  }

  void _initStartCard(CarouselController carouselController) {
    if (carouselController.ready && !isLoaded) {
      isLoaded = true;
      carouselController.animateToPage(widget.initPageNumber);
    }
  }
}
