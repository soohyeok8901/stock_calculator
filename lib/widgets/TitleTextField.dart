import 'package:averge_price_calc/constant.dart';
import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    @required this.titleTextController,
  });

  final TextEditingController titleTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 16),
      child: TextField(
        controller: titleTextController,
        decoration: InputDecoration(
          hintText: '타이틀',
          // suffixIcon: (titleTextController.text != null)
          //     ? IconButton(
          //         icon: Icon(Icons.done_outline),
          //         color: green,
          //         onPressed: () {},
          //       )
          //     : null),
        ),
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23),
        maxLength: 12,
      ),
    );
  }
}
