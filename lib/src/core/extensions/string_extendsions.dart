import 'package:intl/intl.dart';

extension StringExtendsions on String? {
  String? toLicensePlate() {
    if (this == null || this!.isEmpty) {
      return this;
    }

    final license = this?.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    return '${license?.substring(0, 3).toUpperCase()}-${license?.substring(3, 7)}';
  }

  double fromMoney({String locale = 'pt_BR', String symbol = 'R\$'}) {
    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.parse(this ?? '0').toDouble();
  }
}
