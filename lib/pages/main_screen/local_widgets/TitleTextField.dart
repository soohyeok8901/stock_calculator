import 'package:averge_price_calc/constant.dart';
import 'package:averge_price_calc/provider/providers.dart';
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
  TitleWidgetProvider titleProvider;
  @override
  Widget build(BuildContext context) {
    titleProvider = Provider.of<TitleWidgetProvider>(context);
    return showTitle(modifyMode);
  }

  Widget showTitle(modifyMode) {
    return titleProvider.modifyMode ? showTextField() : showText();
  }

  // bool toggleModifyMode() {
  //   print('모드변경 =>  $modifyMode');
  //   return modifyMode = !modifyMode;
  // }

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
            setState(() {
              titleProvider.toggleModifyMode();
            });
          },
        ),
      ],
    );
  }

  Widget showTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 70,
          width: 230,
          child: TextField(
            controller: widget.titleTextController,
            decoration: InputDecoration(
              hintText: '계산기 별명',
            ),
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23),
            maxLength: 10,
            onChanged: widget.onChangedCB,
          ),
        ),
        (widget.titleTextController.text.length > 0)
            ? Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: IconButton(
                  icon: Icon(Icons.done_outline),
                  color: green,
                  onPressed: () {
                    setState(() {
                      titleProvider.toggleModifyMode();
                      widget.onPressedCB();
                    });
                  },
                ),
              )
            : Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: IconButton(
                  icon: Icon(Icons.done_outline),
                  color: green,
                  onPressed: null,
                ),
              )
      ],
    );
  }
}
