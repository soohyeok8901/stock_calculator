import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';

const INF = double.infinity;
Color green = Color(0xFF44D375);
Color weakGreen = Color(0xFFf3ffed);
Color red = Color(0xFFDF4053);
Color weakRed = Color(0xFFF5E1DD);
Color grey = Color(0xFF8D8D8D);

//////////////////////////// Emoji Container
const kEmojiTextStyle = TextStyle(
  fontSize: 100,
);

const kTextAlignCenter = TextAlign.center;

var kEmojiContainerBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(100),
);

//////////////////////////// main Conatiner
const kMainContainerBorderRadius = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(19),
    topLeft: Radius.circular(19),
  ),
);

const kGreyDivider = Divider(
  height: 10,
  thickness: 1.22,
  color: Colors.grey,
);

///////////////////////////// buttonBuilder
const kClearButtonText = Text(
  '초기화',
  style: TextStyle(
    color: Colors.white,
    fontSize: 27,
  ),
);

const kCalculateButtonText = Text(
  '계산',
  style: TextStyle(
    color: Colors.white,
    fontSize: 27,
  ),
);

/////////////////////////////ResultBox
const kTotalValuationTitle = AutoSizeText(
  '평가총액',
  style: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  ),
  maxLines: 1,
);

const kTotalValuationTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const kYieldTitle = AutoSizeText(
  '수익률',
  style: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  ),
  maxLines: 1,
);

const kPurchasePriceTitle = AutoSizeText(
  '평단가  ',
  style: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  ),
  maxLines: 1,
);

const kAveragePurchaseDiffTextStyle = TextStyle(
  fontSize: 23,
  textBaseline: TextBaseline.alphabetic,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Cafe24Simplehae',
);
