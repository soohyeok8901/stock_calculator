import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';

import '../../../constant.dart';

class ListAddCard extends StatelessWidget {
  const ListAddCard({
    Key key,
    this.uiProvider,
  }) : super(key: key);

  final UiDataProvider uiProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('listView에서 카드 추가');
        uiProvider.addCard();
      },
      child: Icon(
        Icons.add,
        size: 65.h,
        color: grey,
      ),
    );
  }
}
