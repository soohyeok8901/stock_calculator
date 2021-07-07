import 'dart:math';

import 'package:averge_price_calc/constant.dart';
import 'package:averge_price_calc/provider/wise_saying_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WiseSayingGenerator extends StatefulWidget {
  @override
  _WiseSayingGeneratorState createState() => _WiseSayingGeneratorState();
}

Random _random = Random();
int _randInt = _random.nextInt(22);
int _index = _randInt;

class _WiseSayingGeneratorState extends State<WiseSayingGenerator> {
  @override
  Widget build(BuildContext context) {
    List wiseSayingList =
        Provider.of<WiseSayingProvider>(context).wiseSayingList;

    print(_index);
    print(wiseSayingList.length);
    return Container(
      decoration: kMainContainerBorderRadius,
      width: INF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              wiseSayingList[_index].sentence,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                  ),
                  onPressed: () {
                    if (_index < 1) {
                      _index = wiseSayingList.length - 1;
                    } else {
                      _index--;
                    }
                    setState(() {});
                  }),
              Text(
                '${_index + 1} / ${wiseSayingList.length}',
                style: TextStyle(fontSize: 12),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    size: 30,
                  ),
                  onPressed: () {
                    if (_index > wiseSayingList.length - 2) {
                      _index = 0;
                    } else {
                      _index++;
                    }
                    setState(() {});
                  }),
            ],
          )
        ],
      ),
    );
  }
}
