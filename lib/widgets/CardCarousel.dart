import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class CardCarousel extends StatelessWidget {
  CardCarousel({this.mainScreenUiCb});

  final Function mainScreenUiCb;
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
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
                onPageChanged: (index, reason) {
                  print(index);
                  uiProvider.nowPageIndex = index;
                  uiProvider.loadUiByChangedPage(
                      index: index); //ui_data_provider.dart data 갱신
                  mainScreenUiCb(); // main_screen.dart textField 갱신
                },
              ),
              itemBuilder: (context, index, _) {
                StockCard cardData = uiProvider.stockCardList[index];
                if (uiProvider.stockCardList[index].isEnd) {
                  return AddCard(mainScreenUiCb: mainScreenUiCb);
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
}

class AddCard extends StatelessWidget {
  const AddCard({
    Key key,
    @required this.mainScreenUiCb,
  }) : super(key: key);

  final Function mainScreenUiCb;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: kCarouselCardDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MaterialButton(
            color: Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<UiDataProvider>(context, listen: false).addCard();
              mainScreenUiCb();
            },
          )
        ],
      ),
    );
  }
}

class MainCard extends StatelessWidget {
  const MainCard({
    Key key,
    @required this.cardData,
    this.index,
  }) : super(key: key);
  final index;
  final StockCard cardData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 500,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: kCarouselCardDecoration,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //              카드 생성 파트
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        '씹씹이 가즈아 ${cardData.emoji}',
                        style: TextStyle(fontSize: 23.0),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              '평가금액',
                              style: TextStyle(color: grey, fontSize: 12),
                            ),
                          ),
                          AutoSizeText(
                            '${cardData.totalValuationResultText}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          AutoSizeText(''),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              '평가손익',
                              style: TextStyle(color: grey, fontSize: 12),
                            ),
                          ),
                          AutoSizeText(
                            '${cardData.valuationResultText}',
                            style: TextStyle(
                              color: cardData.primaryColor,
                              fontSize: 15,
                            ),
                          ),
                          AutoSizeText(
                            '${cardData.valuationLossDiffText}',
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              '수익률',
                              style: TextStyle(color: grey, fontSize: 12),
                            ),
                          ),
                          AutoSizeText(
                            '${cardData.yieldResultText}',
                            style: TextStyle(
                              color: cardData.primaryColor,
                              fontSize: 15,
                            ),
                          ),
                          AutoSizeText(
                            '${cardData.yieldDiffText}',
                            style: TextStyle(
                              fontSize: 9,
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
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              '평단가',
                              style: TextStyle(color: grey, fontSize: 12),
                            ),
                          ),
                          AutoSizeText(
                            '${cardData.purchasePriceResultText}',
                            style: TextStyle(
                              color: cardData.primaryColor,
                              fontSize: 15,
                            ),
                          ),
                          AutoSizeText(
                            '${cardData.averagePurchaseDiffText}',
                            style: TextStyle(
                              fontSize: 9,
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
        (index == 0)
            ? SizedBox()
            : Positioned(
                left: 262,
                child: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.black,
                  onPressed: () {
                    Provider.of<UiDataProvider>(context, listen: false)
                        .deleteCard(index: index);
                  },
                ),
              ),
      ],
    );
  }
}
