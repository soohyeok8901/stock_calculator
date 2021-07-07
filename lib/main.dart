import 'package:averge_price_calc/pages/main_screen/main_screen.dart';
import 'package:averge_price_calc/provider/cardCarousel_provider.dart';
import 'package:averge_price_calc/provider/title_widget_provider.dart';
import 'package:averge_price_calc/provider/ui_data_provider.dart';
import 'package:averge_price_calc/provider/wise_saying_provider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'utils/calculator.dart';
import 'pages/screens.dart';

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
        ChangeNotifierProvider<CardCarouselProvider>(
          create: (_) => CardCarouselProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(392.72727272727275, 759.2727272727273),
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: MainScreen.id,
            routes: {
              MainScreen.id: (context) => MainScreen(),
              ListScreen.id: (context) => ListScreen(),
              HelpScreen.id: (context) => HelpScreen(),
            },
            theme: ThemeData(fontFamily: 'GmarketSansMedium')),
      ),
    );
  }
}
