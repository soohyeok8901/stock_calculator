import 'package:averge_price_calc/models/ui_data.dart';
import 'package:averge_price_calc/pages/main_screen.dart';
import 'package:averge_price_calc/widgets/ui_data_provider.dart';
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
        ChangeNotifierProvider<HandleUiDataProvider>(
          create: (_) => HandleUiDataProvider(),
        ),
        ChangeNotifierProvider<CalcBrain>(
          create: (_) => CalcBrain(),
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
