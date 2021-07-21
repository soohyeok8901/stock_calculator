import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/provider/providers.dart';

import '../../constant.dart';
import 'local_widgets/main_screen_widgets.dart';

class OptionScreen extends StatelessWidget {
  //TODO: OptionBottomSheet로부터 title args를 받아야합니다.
  static String id = 'option_screen';
  OptionScreen({this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            (Provider.of<UiDataProvider>(context).primaryColor == grey)
                ? grey
                : (Provider.of<UiDataProvider>(context).primaryColor == red)
                    ? buttonRed
                    : buttonBlue,
        title: Padding(
          padding: EdgeInsets.only(left: 67.w),
          child: Text(
            '계산기 설정',
          ),
        ),
      ),
      body: SafeArea(child: Consumer<UiDataProvider>(
        builder: (context, uiDataProvider, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.h),
              titleText('별명 변경'),
              Text(
                uiDataProvider.title ?? '계산기 1',
                style: TextStyle(fontSize: 34.sp),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    enabledBorder: kInputTextFieldEnableBorder,
                    focusedBorder: kInputTextFieldFocusedBorder,
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //TODO: uiDataProvider setTitle 메서드 불러오기
                  },
                ),
              ),
              kGreyDivider,
              titleText('통화 선택'),
              kGreyDivider,
              titleText('환율 변경'),
            ],
          );
        },
      )),
    );
  }

  Center titleText(String title) {
    return Center(
      child: Container(
        // color: Colors.white,
        width: 180.w,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 18.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
