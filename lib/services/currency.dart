import 'package:hive/hive.dart';
import 'package:penger/models/currency.dart';

class CurrencyService {

  static Future<CurrencyModel> create(Map<String, dynamic> currency) async {
    final currencyBox = await Hive.openBox(CurrencyModel.currencyBox);

    var currencyModel = CurrencyModel.fromMap(currency);

    await currencyBox.put(currencyModel.id, currencyModel);
    return currencyModel;
  }

  static Future<List<CurrencyModel>> createCurrencies(List currencies) async {
    final currencyBox = await Hive.openBox(CurrencyModel.currencyBox);
    await currencyBox.clear();

    List<CurrencyModel> currencyModels = [];

    for(var currency in currencies){
      var currencyModel = CurrencyModel.fromMap(currency);

      await currencyBox.put(currencyModel.id, currencyModel);
      currencyModels.add(currencyModel);
    }

    return currencyModels;
  }
}