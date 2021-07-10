import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/provider/ui_data_provider.dart';
import 'package:stock_calculator/constant.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    Key key,
    @required TextEditingController titleTextController,
    @required this.index,
    @required this.carouselController,
  })  : _titleTextController = titleTextController,
        super(key: key);

  final TextEditingController _titleTextController;
  final int index;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
      ),
      onSelected: (value) async {
        if (value == '이름변경') {
          print('이름변경 선택');
          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        '이름 변경  ✏️',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    content: SizedBox(
                      width: 500.w,
                      height: 140.h,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.h),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                Provider.of<UiDataProvider>(context,
                                        listen: false)
                                    .changeTitleData(_titleTextController.text);
                              });
                            },
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            controller: _titleTextController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.h,
                                horizontal: 15.w,
                              ),
                              hintText: "계산기 별명",
                            ),
                            maxLength: 10,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                height: 30.h,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey[400]),
                                ),
                                color: Colors.white,
                                focusColor: Colors.black,
                                disabledColor: grey,
                                disabledTextColor: Colors.white,
                                child: Text(
                                  "수정하기",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_titleTextController.text.length > 0) {
                                    setState(() {
                                      Provider.of<UiDataProvider>(context,
                                              listen: false)
                                          .setTitle();
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (value == '삭제') {
          print('삭제 선택');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  '삭제하시겠습니까?  ⚠️',
                  textAlign: TextAlign.center,
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
                      ),
                      onPressed: () {
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
                      ),
                      onPressed: () {
                        Provider.of<UiDataProvider>(context, listen: false)
                            .deleteCard(index: index);
                        if (carouselController.ready) {
                          carouselController.jumpToPage(index - 1);
                        }
                        Navigator.pop(context);
                      },
                      child: Text('예'),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          print('뭐야');
        }
      },
      shape: Border.all(),
      itemBuilder: (context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            value: "이름변경",
            height: 23.h,
            child: Text(
              '이름변경',
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
          (index != 0) ? PopupMenuDivider(height: 23.h) : null,
          (index != 0)
              ? PopupMenuItem(
                  value: "삭제",
                  height: 23.h,
                  child: Text(
                    '삭제',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                )
              : null,
        ];
      },
    );
  }
}
