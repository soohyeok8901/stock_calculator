import 'package:intl/intl.dart';

//통화단위(원) 붙이기
String currencyFormat(int price) {
  final formatCurrency = new NumberFormat.simpleCurrency(
      locale: "ko_KR", name: "", decimalDigits: 0);
  return formatCurrency.format(price);
}

//원, 괄호 붙이기
String addSuffixWonWithBrackets(String value) {
  return '($value 원)';
}

String addSuffixPercent(double value) {
  return '${value.toStringAsFixed(2)} %';
}

String addSuffixWon(String value) {
  return '$value 원';
}
