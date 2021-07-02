import 'dart:ffi';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:averge_price_calc/models/stock_card.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardCarousel extends StatelessWidget {
  const CardCarousel({
    Key key,
  });

  //TODO: stockCardList를 이용해서 캐러샐과연동을 해봅시다.
  //TODO: i-1 은 추가 카드인점 명심하세요.
  //TODO: 리팩토링
  @override
  Widget build(BuildContext context) {
    int pageIndex = -1; //카드 동적생성 관리용 index
    // Provider.of<HandleUiDataProvider>(context).;
    return Consumer<HandleUiDataProvider>(
      builder: (context, handleUidDataProvider, widget) {
        return CarouselSlider(
          options: CarouselOptions(
            height: 130,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              //TODO:여기에 슬라이드 했을 때 ui_data_provider에 ui<->data 연동 메서드 만들어서
              //TODO: 데이터 동기화 되게 만들면 되겠네요 근데 reason은 뭐죠
              print(index);
              handleUidDataProvider.nowPageIndex = index;
            },
          ),
          items: handleUidDataProvider.stockCardList.map((i) {
            print('${i.totalValuationResultText} ${i.isEnd}');
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: makeCards(
                    cardData: i,
                    context: context,
                    // pageIndex: pageIndex,
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  //카드위젯 동적생성
  Column makeCards({StockCard cardData, BuildContext context}) {
    // print(cardData.totalValuationResultText);
    // print(cardData.isEnd);
    if (cardData.isEnd && cardData.totalValuationResultText == null) {
      // 새카드는 결과텍스트가 0 원으로 입력 받은 상태
      //TODO:추가카드 생성해봅시다.
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Provider.of<HandleUiDataProvider>(context, listen: false)
                  .addCard();
              //TODO: 데이터도 연동(초기화 된듯한 ui)
              //TODO: sharedPreferences stockCardList save시키기
            },
          ),
        ],
      );
    } else {
      // TODO: 데이터를 이용해서 정상적인 캐러샐 카드 리턴
      return Column(
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
      );
    }
  }
}
