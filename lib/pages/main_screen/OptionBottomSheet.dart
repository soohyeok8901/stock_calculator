import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';

import './local_widgets/main_screen_widgets.dart';
import '../../constant.dart';
import 'OptionScreen.dart';

class OptionBottomSheet extends StatelessWidget {
  const OptionBottomSheet({this.carouselController});

  final CarouselController carouselController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // decoration: modalOutBoxDecoration,
        child: Container(
          height: 200.h,
          // decoration: modalInBoxDecoration,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 17.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  splashColor: grey,
                  child: SizedBox(
                    height: 40.h,
                    width: 100.w,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: Colors.grey[700],
                          size: 30.sp,
                        ),
                        SizedBox(width: 35.w),
                        Text(
                          '계산기 설정',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    //TODO: OptionBottomSheet로 title args를 줘야합니다.
                    Navigator.pushNamed(context, OptionScreen.id);
                  },
                ),
                SizedBox(height: 15.h),
                InkWell(
                  child: SizedBox(
                    height: 40.h,
                    width: 100.w,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.grey[700],
                          size: 30.sp,
                        ),
                        SizedBox(width: 35.w),
                        Text(
                          '삭제',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteDialog(
                            carouselController: carouselController);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
