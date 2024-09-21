import 'package:hive/hive.dart';

part 'currency.g.dart';

@HiveType(typeId: 2)
class CurrencyModel {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String code;

  @HiveField(3)
  late String symbol;

  @HiveField(4)
  late String symbolPosition;

  @HiveField(5)
  late String thousandSeparator;

  @HiveField(6)
  late String decimalSeparator;

  @HiveField(7)
  late int decimalPlaces;

  @HiveField(8)
  late String sample;

  static String currencyBox = 'currencies';

  static CurrencyModel fromMap(Map<String, dynamic> currency) {
    var currencyModel = CurrencyModel();
    currencyModel.id = currency['id'];
    currencyModel.name = currency['name'];
    currencyModel.code = currency['code'];
    currencyModel.symbol = currency['symbol'];
    currencyModel.symbolPosition = currency['symbol_position'];
    currencyModel.thousandSeparator = currency['thousand_separator'];
    currencyModel.decimalSeparator = currency['decimal_separator'];
    currencyModel.decimalPlaces = currency['decimal_places'];
    currencyModel.sample = currency['sample'];

    return currencyModel;
  }

  bool isEqual(CurrencyModel model) {
    return id == model.id;
  }

  @override
  String toString() => "$name ($code)";
}
