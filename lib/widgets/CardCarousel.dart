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
  @override
  Widget build(BuildContext context) {
    // Provider.of<HandleUiDataProvider>(context).;
    return Consumer<HandleUiDataProvider>(
      builder: (context, handleUidDataProvider, widget) {
        return CarouselSlider(
          options: CarouselOptions(
            height: 100,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              //TODO:여기에 슬라이드 했을 때 ui_data_provider에 ui<->data 연동 메서드 만들어서
              //TODO: 데이터 동기화 되게 만들면 되겠네요 근데 reason은 뭐죠
            },
          ),
          items: handleUidDataProvider.stockCardList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: makeCards(cardData: i),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  //카드위젯 동적생성
  Column makeCards({StockCard cardData}) {
    // List<CoinCard> cards = [];
    // for (String crypto in kCryptoList) {
    //   cards.add(
    //     CoinCard(
    //         dropdownValue: dropdownValue,
    //         ticker: crypto,
    //         price: isWaiting ? '?' : coinValues[crypto]),
    //   );
    // }

    //TODO: 인덱스를 확인해야겠네요
    //TODO: 인덱스가 i-1 일 경우 추가카드를 return 합시다.

    if (cardData.isEnd) {
      //TODO:추가카드 생성해봅시다.
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //TODO: 여기에는 i-2 (개수 계산필요)에다가 빈 계산기 생성
              //TODO: List에 i-2( 개수 계산필요) 인덱스에 새로운 요소 추가
              //TODO: 데이터도 연동(초기화 된듯한 ui)
            },
          ),
        ],
      );
    } else {
      // 데이터를 이용해서 정상적인 캐러샐 카드 리턴
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //              카드 생성 파트
        children: <Widget>[
          Text(
            cardData.title,
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                cardData.totalValuationResultText,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 4),
              Text(
                cardData.yieldResultText,
                style: TextStyle(
                  color: cardData.primaryColor,
                  fontSize: 17,
                ),
              ),
            ],
          )
        ],
      );
    }
  }
}
