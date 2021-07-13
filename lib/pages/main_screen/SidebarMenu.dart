import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/constant.dart';
import 'package:stock_calculator/pages/help_screen/help_screen.dart';
import 'package:stock_calculator/pages/list_screen/list_screen.dart';
import 'package:stock_calculator/provider/providers.dart';

class SideBarMenu extends StatelessWidget {
  // static String id = 'sidebar_menu';
  // SideBarMenu({this.scaffoldKey});

  // GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230.w,
      child: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.h,
              child: DrawerHeader(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Center(
                  child: Text(
                    '주식 계산기',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Provider.of<UiDataProvider>(context).primaryColor,
                ),
              ),
            ),
            ListTile(
              // leading: Icon(Icons.home),
              title: Text(
                '계산기 목록 🔎',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, ListScreen.id),
              },
            ),
            kGreyDivider,
            ListTile(
              // leading: Icon(Icons.shopping_cart),
              title: Text(
                '설명서 💡',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, HelpScreen.id),
              },
            ),
            kGreyDivider,
            ListTile(
              // leading: Icon(Icons.shopping_cart),
              title: Text(
                '피드백 주러 가기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {
                //TODO: 앱스토어로 리다이렉팅
              },
            ),
            Spacer(),
            Text(
              '49Moongchi',
              style: TextStyle(color: grey),
            ),
            SizedBox(height: 30.h)
          ],
        ),
      ),
    );
  }
}
