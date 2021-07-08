import 'package:stock_calculator/pages/list_screen/local_widgets/ListCard.dart';
import 'package:stock_calculator/provider/cardCarousel_provider.dart';
import 'package:stock_calculator/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  static String id = 'list_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiDataProvider, CardCarouselProvider>(
      builder: (context, uiProvider, cardCarouselProvider, widget) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Provider.of<UiDataProvider>(context).primaryColor,
            title: Text('계산기 목록'),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              if (!uiProvider.stockCardList[index].isEnd) {
                return InkWell(
                  onTap: () {
                    print('${uiProvider.stockCardList[index].title} 클릭');
                    Navigator.pop(context);
                    if (cardCarouselProvider.carouselController.ready) {
                      cardCarouselProvider.carouselController.jumpToPage(index);
                    }
                  },
                  child: ListCard(
                    uiProvider: uiProvider,
                    index: index,
                  ),
                );
              } else {
                return null;
              }
            },
            itemCount: uiProvider.stockCardList.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
