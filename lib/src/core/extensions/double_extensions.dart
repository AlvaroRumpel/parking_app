import 'package:intl/intl.dart';

extension ToMoney on double {
  String toMoney({String locale = 'pt_BR', String symbol = 'R\$'}) {
    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.format(this);
  }
}
