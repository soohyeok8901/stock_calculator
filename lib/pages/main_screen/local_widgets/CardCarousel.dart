import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:averge_price_calc/provider/providers.dart';
import 'package:averge_price_calc/provider/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _initStartCard();

    return Column(
      children: [
        Consumer2<UiDataProvider, TitleWidgetProvider>(
          builder: (context, uiProvider, titleProvider, widget) {
            return CarouselSlider.builder(
              itemCount: uiProvider.stockCardList.length,
              carouselController: carouselController,
              options: CarouselOptions(
                height: 190,
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
                },
              ),
              itemBuilder: (context, index, _) {
                StockCard cardData = uiProvider.stockCardList[index];
                if (uiProvider.stockCardList[index].isEnd) {
                  return AddCard(
                    mainScreenUiCb: cb,
                    lastIndex: uiProvider.stockCardList.length - 1,
                    carouselController: carouselController,
                  );
                } else {
                  return MainCard(cardData: cardData, index: index);
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
        uiProvider.nowPageIndex != uiProvider.stockCardList.length - 1);
  }

  void _initStartCard() {
    if (carouselController.ready && !isLoaded) {
      isLoaded = true;
      carouselController.animateToPage(widget.initPageNumber);
    }
  }
}
