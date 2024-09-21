import 'package:dio/dio.dart';
import 'package:penger/models/currency.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/services/api.dart';
import 'package:penger/services/api_routes.dart';
import 'package:penger/models/result.dart';
import 'package:penger/services/currency.dart';

class CurrencyController {
  static Future<Result<List<CurrencyModel>>> load() async {
    try {
      final response = await ApiService.get(ApiRoutes.currencyUrl, {});

      final results = response.data['results'];
      final currencies = await CurrencyService.createCurrencies(results['currencies']);

      return Result(isSuccess: true, message: response.data['message'], results: currencies);
    }  on DioException catch (e) {
      final message = ApiService.errorMessage(e);
      final errors = e.response?.data['errors'];

      return Result(isSuccess: false, message: message, errors: errors);
    } catch (e) {
      return Result(isSuccess: false, message: AppStrings.anErrorOccurredTryAgain);
    }
  }
}
