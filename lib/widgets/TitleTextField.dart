import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    @required this.titleTextController,
  });

  final TextEditingController titleTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
      child: TextField(
        controller: titleTextController,
        decoration: InputDecoration(
            hintText: '타이틀',
            suffixIcon: (titleTextController.text != '')
                ? IconButton(
                    icon: Icon(Icons.done_outline),
                    onPressed: () {},
                  )
                : null),
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23),
        maxLength: 12,
      ),
    );
  }
}
