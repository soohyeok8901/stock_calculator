import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';

import '../../../constant.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    @required this.uiDataProvider,
    @required this.onPressedCB,
    @required this.childTextWidget,
  });

  final UiDataProvider uiDataProvider;
  final Function onPressedCB;
  final Widget childTextWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 30.w,
      height: 60.h,
      // color: Color(0xFF566270),
      // color: Color(0xFF4F86C6),
      color: (uiDataProvider.primaryColor == grey)
          ? buttonGrey
          : (uiDataProvider.primaryColor == red)
              ? buttonRed
              : buttonBlue,
      child: childTextWidget,
      onPressed: onPressedCB,
      elevation: 8,
      shape: kRoundedRectangleBorder,
    );
  }
}
