import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

//TODO: 캐러샐 카드 꾸미기
class CardCarousel extends StatelessWidget {
  const CardCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 100,
        enableInfiniteScroll: false,
      ),
      items: [1, 2, 3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '타이틀',
                    style: TextStyle(fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '65,413 원',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(-30%)',
                        style: TextStyle(color: Colors.blue[800]),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
