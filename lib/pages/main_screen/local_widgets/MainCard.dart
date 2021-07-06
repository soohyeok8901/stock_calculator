import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:averge_price_calc/constant.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:averge_price_calc/provider/ui_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_screen_widgets.dart';

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
                    if (carouselController.ready) {
                      carouselController.jumpToPage(index - 1);
                    }
                  },
                ),
              ),
      ],
    );
  }
}
