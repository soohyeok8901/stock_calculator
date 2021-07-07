import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardCarouselProvider extends ChangeNotifier {
  final CarouselController carouselController = CarouselController();
  bool isLoaded = false;
}
