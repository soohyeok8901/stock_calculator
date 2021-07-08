import 'package:stock_calculator/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    @required this.textController,
    @required this.titleText,
    @required this.hintText,
    @required this.onChangedCB,
  });

  final TextEditingController textController;
  final String titleText;
  final String hintText;
  final Function onChangedCB;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          titleText,
          style: kInputTextFieldTitleTextStyle,
        ),
        SizedBox(height: 8.h),
        Container(
          height: 33.h,
          width: 200.w,
          child: TextField(
            controller: textController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')), //0~9만 입력가능
            ],
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: kInputTextFieldEnableBorder,
              focusedBorder: kInputTextFieldFocusedBorder,
            ),
            onChanged: onChangedCB,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
