import 'package:averge_price_calc/pages/main_screen/main_screen.dart';
import 'package:averge_price_calc/provider/title_widget_provider.dart';
import 'package:averge_price_calc/provider/ui_data_provider.dart';
import 'package:averge_price_calc/provider/wise_saying_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'models/calculator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(AverageCalculator());
}

class AverageCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UiDataProvider>(
          create: (_) => UiDataProvider(),
        ),
        ChangeNotifierProvider<CalcBrain>(
          create: (_) => CalcBrain(),
        ),
        ChangeNotifierProvider<WiseSayingProvider>(
          create: (_) => WiseSayingProvider(),
        ),
        ChangeNotifierProvider<TitleWidgetProvider>(
          create: (_) => TitleWidgetProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(1440, 2960),
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: MainScreen(),
            theme: ThemeData(fontFamily: 'GmarketSansMedium')),
      ),
    );
  }
}
