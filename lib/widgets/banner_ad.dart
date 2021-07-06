import 'package:averge_price_calc/constant.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

//TODO: 애드몹 배포버전으로 수정

class ShowBannerAd extends StatefulWidget {
  @override
  _ShowBannerAdState createState() => _ShowBannerAdState();
}

class _ShowBannerAdState extends State<ShowBannerAd> {
  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111', //test
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: AdWidget(ad: myBanner),
      width: INF,
      height: myBanner.size.height.toDouble(),
    );
  }
}
