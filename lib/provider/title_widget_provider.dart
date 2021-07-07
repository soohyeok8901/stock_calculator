import 'package:flutter/material.dart';

class TitleWidgetProvider extends ChangeNotifier {
  bool _modifyMode = false;

  void toggleModifyMode() {
    _modifyMode = !_modifyMode;
  }

  void setFalse() {
    _modifyMode = false;
  }

  get modifyMode {
    return _modifyMode;
  }
}
