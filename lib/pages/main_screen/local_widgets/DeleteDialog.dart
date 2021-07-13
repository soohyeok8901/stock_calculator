import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    Key key,
    @required this.carouselController,
  }) : super(key: key);

  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '삭제하시겠습니까?  ⚠️',
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          MaterialButton(
            minWidth: 30.w,
            height: 30.h,
            // color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[500]),
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('아니오'),
          ),
          SizedBox(width: 10.w),
          MaterialButton(
            minWidth: 30.w,
            height: 30.h,
            // color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[500]),
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {
              Provider.of<UiDataProvider>(context, listen: false).deleteCard(
                  index: Provider.of<UiDataProvider>(context, listen: false)
                      .nowPageIndex);
              if (carouselController.ready) {
                carouselController.jumpToPage(
                    Provider.of<UiDataProvider>(context, listen: false)
                            .nowPageIndex -
                        1);
              }
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('예'),
          ),
        ],
      ),
    );
  }
}
