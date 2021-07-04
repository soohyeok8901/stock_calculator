import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class CardCarousel extends StatefulWidget {
  CardCarousel({this.mainScreenUiCb});

  final Function mainScreenUiCb;
  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final CarouselController carouselController = CarouselController();
  Function cb;

  @override
  void initState() {
    super.initState();
    cb = widget.mainScreenUiCb();
  }

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
                height: 130,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  print(index);
                  uiProvider.nowPageIndex = index;
                  uiProvider.loadUiByChangedPage(
                      index: index); //ui_data_provider.dart data 갱신
                  cb(); // main_screen.dart textField 갱신
                },
              ),
              itemBuilder: (context, index) {
                StockCard cardData = uiProvider.stockCardList[index];
                if (uiProvider.stockCardList[index].isEnd) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: kCarouselCardDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            print('버튼눌렸습니다.');
                            carouselController.jumpToPage(
                                uiProvider.stockCardList.length -
                                    1); //it should be work

                            Provider.of<UiDataProvider>(context, listen: false)
                                .addCard();

                            ///TODO: sharedPreferences stockCardList save시키기
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  // TODO: 데이터를 이용해서 정상적인 캐러샐 카드 리턴
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //              카드 생성 파트
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              '씹씹이 가즈아 ${cardData.emoji}',
                              style: TextStyle(fontSize: 30.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        AutoSizeText(
                          '${cardData.totalValuationResultText}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        AutoSizeText(
                          '${cardData.valuationResultText}',
                          style: TextStyle(
                            color: cardData.primaryColor,
                            fontSize: 17,
                          ),
                        ),
                        AutoSizeText(
                          '${cardData.yieldResultText}',
                          style: TextStyle(
                            color: cardData.primaryColor,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
        //delete test
        RaisedButton(onPressed: () {
          Provider.of<UiDataProvider>(context, listen: false).deleteCard(
              index: Provider.of<UiDataProvider>(context, listen: false)
                      .stockCardList
                      .length -
                  2);
        }),
      ],
    );
  }
}
