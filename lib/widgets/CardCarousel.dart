import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddCard.dart';
import 'MainCard.dart';

final CarouselController carouselController = CarouselController();
bool isLoaded = false;

class CardCarousel extends StatelessWidget {
  CardCarousel({this.mainScreenUiCb, this.initPageNumber});

  final Function mainScreenUiCb;
  final int initPageNumber;

  @override
  Widget build(BuildContext context) {
    _initStartCard();

    return Column(
      children: [
        Consumer<UiDataProvider>(
          builder: (context, uiProvider, widget) {
            return CarouselSlider.builder(
              itemCount: uiProvider.stockCardList.length,
              carouselController: carouselController,
              options: CarouselOptions(
                height: 190,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                initialPage: initPageNumber,
                onPageChanged: (index, reason) {
                  uiProvider.nowPageIndex = index;
                  uiProvider.loadUiByChangedPage(
                      index: index); //ui_data_provider.dart data 갱신
                  mainScreenUiCb(); // main_screen.dart textField 갱신
                },
              ),
              itemBuilder: (context, index, _) {
                StockCard cardData = uiProvider.stockCardList[index];
                if (uiProvider.stockCardList[index].isEnd) {
                  return AddCard(
                    mainScreenUiCb: mainScreenUiCb,
                    initPageNumber: initPageNumber,
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

  void _initStartCard() {
    if (carouselController.ready && !isLoaded) {
      isLoaded = true;
      carouselController.animateToPage(initPageNumber);
    }
  }
}
