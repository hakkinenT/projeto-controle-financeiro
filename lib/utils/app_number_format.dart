import 'package:intl/intl.dart';

class AppNumberFormat {
  static String getCurrency(double value) {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(value);
  }

  static String getPercentage(double value) {
    NumberFormat formatter = NumberFormat.percentPattern('pt_BR');
    return formatter.format(value);
  }
}
