import 'package:flutter/material.dart';

import '../constant.dart';

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
        SizedBox(height: 8),
        Container(
          height: 43,
          width: 200,
          child: TextField(
            controller: textController,
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
