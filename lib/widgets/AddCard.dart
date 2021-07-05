import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class AddCard extends StatelessWidget {
  const AddCard({
    @required this.mainScreenUiCb,
    this.initPageNumber,
    this.carouselController,
  });
  final int initPageNumber;
  final Function mainScreenUiCb;
  final CarouselController carouselController;
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
