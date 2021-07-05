import 'package:averge_price_calc/constant.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool modifyMode = false;

class TitleTextField extends StatefulWidget {
  const TitleTextField({
    @required this.titleTextController,
    @required this.onChangedCB,
    @required this.onPressedCB,
    @required this.context,
  });

  final TextEditingController titleTextController;
  final Function onChangedCB;
  final Function onPressedCB;
  final BuildContext context;

  @override
  _TitleTextFieldState createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  @override
  Widget build(BuildContext context) {
    return showTitle(modifyMode);
  }

  Widget showTitle(modifyMode) {
    return modifyMode ? showTextField() : showText();
  }

  bool toggleModifyMode() {
    print('모드변경 =>  $modifyMode');
    return modifyMode = !modifyMode;
  }

  Widget showText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            widget.titleTextController.text,
            // 'asda',
            style: TextStyle(fontSize: 23),
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            toggleModifyMode();
          },
        ),
      ],
    );
  }

  Widget showTextField() {
    return TextField(
      controller: widget.titleTextController,
      decoration: InputDecoration(
          hintText: '타이틀',
          suffixIcon: (widget.titleTextController.text.length > 0)
              ? IconButton(
                  icon: Icon(Icons.done_outline),
                  color: green,
                  onPressed: () {
                    toggleModifyMode();
                    widget.onPressedCB();
                  },
                )
              : null),
      textAlignVertical: TextAlignVertical.bottom,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 21.5),
      maxLength: 12,
      onChanged: widget.onChangedCB,
    );
  }
}
