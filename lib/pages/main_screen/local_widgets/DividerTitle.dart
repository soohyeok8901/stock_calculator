import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant.dart';

class DividerTitle extends StatelessWidget {
  const DividerTitle({
    Key key,
    this.textString,
  }) : super(key: key);

  final String textString;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 9.h,
          ),
          child: kGreyDivider,
        ),
        Center(
          child: Container(
            color: Colors.white,
            width: 180.w,
            child: Text(
              textString,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
