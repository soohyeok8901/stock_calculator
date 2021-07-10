import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:stock_calculator/provider/providers.dart';

//TODO: 대충 틀만 잡아봅시다~
class HelpScreen extends StatefulWidget {
  static String id = 'help_screen';
  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설명서'),
        backgroundColor: Provider.of<UiDataProvider>(context).primaryColor,
      ),
      body: ImageSlideshow(
        /// Width of the [ImageSlideshow].
        width: double.infinity,

        /// Height of the [ImageSlideshow].
        height: MediaQuery.of(context).size.height,

        /// The page to show when first creating the [ImageSlideshow].
        initialPage: 0,

        /// The color to paint the indicator.
        indicatorColor: Colors.red,

        /// The color to paint behind th indicator.
        indicatorBackgroundColor: Colors.grey,

        /// The widgets to display in the [ImageSlideshow].
        /// Add the sample image file into the images folder
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/1.png',
                fit: BoxFit.contain,
              ),
              Image.asset(
                'assets/images/2.png',
                fit: BoxFit.contain,
              ),
            ],
          ),
          Image.asset(
            'assets/images/3.png',
            fit: BoxFit.contain,
          ),
        ],

        /// Called whenever the page in the center of the viewport changes.
        onPageChanged: (value) {
          print('Page changed: $value');
        },

        /// Auto scroll interval.
        /// Do not auto scroll with null or 0.
        // autoPlayInterval: 3000,
      ),
    );
  }
}
