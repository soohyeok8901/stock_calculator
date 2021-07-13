import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';

const INF = double.infinity;
Color green = Color(0xFF44D375);
Color red = Colors.red[700];
Color buttonRed = Color(0xFFEC4E4E);
Color blue = Colors.blue[800];
Color buttonBlue = Color(0xFF4F86C6);
Color grey = Color(0xFF8D8D8D);
Color buttonGrey = Color(0xFF566270);

//* main Conatiner
var kMainConatinerPadding = Padding(
  padding: EdgeInsets.fromLTRB(50.w, 10.h, 50.w, 5.h),
  child: Container(),
);

BoxDecoration kMainContainerBoxDecoration(UiDataProvider handleUiDataProvider) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        (handleUiDataProvider.primaryColor == grey)
            ? grey
            : handleUiDataProvider.primaryColor,
        (handleUiDataProvider.primaryColor == grey)
            ? Colors.white
            : (handleUiDataProvider.primaryColor == red)
                ? Color(0xFFFEFFB0)
                : Color(0xFFe8198b),
      ],
      //  #FFE29F , #FFA99F , #FF719A
    ),
  );
}

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

//*InputTextField
var kInputTextFieldTitleTextStyle = TextStyle(
  // fontWeight: FontWeight.bold,
  fontSize: 13.sp,
);

var kInputTextFieldEnableBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: Colors.grey,
    width: 1,
  ),
);

var kInputTextFieldFocusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: Colors.green,
    width: 2,
  ),
);

//*Carousel Card
const kCarouselCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(15)),
);

//* list_screen card
const kListCardDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(15)),
);

//* CustomButton Widget
var kRoundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.r),
);

const kClearButtonText = Text(
  '초기화',
  style: TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
    // fontFamily: 'S-Core_Dream',
  ),
);

const kCalculateButtonText = Text(
  '주가변동에의한 \n수익/손익',
  style: TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
    // fontFamily: 'S-Core_Dream',
  ),
  textAlign: TextAlign.center,
);

const kYieldButtonText = Text(
  '타겟 수익률의\n목표주가',
  style: TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
    // fontFamily: 'S-Core_Dream',
  ),
  textAlign: TextAlign.center,
);

const kAccumulateButtonText = Text(
  '현재잔고기점 \n분할매수',
  style: TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
    // fontFamily: 'S-Core_Dream',
  ),
  textAlign: TextAlign.center,
);

const kDistributeButtonText = Text(
  '현재잔고기점 \n분할매도',
  style: TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
    // fontFamily: 'S-Core_Dream',
  ),
  textAlign: TextAlign.center,
);
