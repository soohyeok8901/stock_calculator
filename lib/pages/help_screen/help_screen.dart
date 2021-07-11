import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/provider/providers.dart';

import '../../constant.dart';

//TODO: 대충 틀만 잡아봅시다~
class HelpScreen extends StatefulWidget {
  static String id = 'help_screen';
  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 97.w),
          child: Text(
            '설명서 💡',
            // style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor:
            (Provider.of<UiDataProvider>(context).primaryColor == grey)
                ? grey
                : (Provider.of<UiDataProvider>(context).primaryColor == red)
                    ? buttonRed
                    : buttonBlue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 17.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '⚠️',
                  style: TextStyle(fontSize: 23.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  '모든 항목에 입력을 해야\n계산 가능합니다!',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '✅',
                  style: TextStyle(fontSize: 23.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  '현재 보유잔고의 평가금액,  보유수량,\n평단가,  현재주가를 입력한 뒤, \n계산해 보고 싶은 주가와 개수을 \n입력하세요.',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '✅',
                  style: TextStyle(fontSize: 23.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  '구매수량을 0으로 입력하면\n추매없이 주가변동만 계산합니다.',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '✅',
                  style: TextStyle(fontSize: 23.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  '구매수량에 10을 입력하면 \n예상 주가에 10주를 \n추매한다는 뜻입니다.',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '✅',
                  style: TextStyle(fontSize: 23.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  '계산기 목록에서 옆으로 슬라이드시키면 \n계산기를 삭제할 수 있습니다.',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '⚠️',
                  style: TextStyle(fontSize: 23.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  '결과는 입력값에 영향을 받기 때문에 \n마구잡이로 입력하면 \n계산이 이상할 수 있습니다.',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
          ],
        ),
      ),
      // body: ImageSlideshow(
      //   /// Width of the [ImageSlideshow].
      //   width: double.infinity,

      //   /// Height of the [ImageSlideshow].
      //   height: MediaQuery.of(context).size.height,

      //   /// The page to show when first creating the [ImageSlideshow].
      //   initialPage: 0,

      //   /// The color to paint the indicator.
      //   indicatorColor: Colors.red,

      //   /// The color to paint behind th indicator.
      //   indicatorBackgroundColor: Colors.grey,

      //   /// The widgets to display in the [ImageSlideshow].
      //   /// Add the sample image file into the images folder
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Image.asset(
      //           'assets/images/1.png',
      //           fit: BoxFit.contain,
      //         ),
      //         Image.asset(
      //           'assets/images/2.png',
      //           fit: BoxFit.contain,
      //         ),
      //       ],
      //     ),
      //     Image.asset(
      //       'assets/images/3.png',
      //       fit: BoxFit.contain,
      //     ),
      //   ],

      //   /// Called whenever the page in the center of the viewport changes.
      //   onPageChanged: (value) {
      //     print('Page changed: $value');
      //   },

      //   /// Auto scroll interval.
      //   /// Do not auto scroll with null or 0.
      //   // autoPlayInterval: 3000,
      // ),
    );
  }
}
