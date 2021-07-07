import 'package:averge_price_calc/constant.dart';
import 'package:averge_price_calc/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpScreen extends StatelessWidget {
  static String id = 'help_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<UiDataProvider>(context).primaryColor,
        title: Text('사용법'),
      ),
      body: Container(
        child: Center(
          child: Text(
            '여기에 사용법 이미지가 들어갈 예정입니다~',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
