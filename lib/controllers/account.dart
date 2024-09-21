import 'package:dio/dio.dart';
import 'package:penger/models/account.dart';
import 'package:penger/models/currency.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/services/account.dart';
import 'package:penger/services/api.dart';
import 'package:penger/services/api_routes.dart';
import 'package:penger/models/result.dart';
import 'package:penger/services/currency.dart';

class AccountController {
  static Future<Result<List<AccountModel>>> load() async {
    try {
      final response = await ApiService.get(ApiRoutes.accountUrl, {});

      final results = response.data['results'];
      final accounts = await AccountService.createAccounts(results['accounts']);

      return Result(isSuccess: true, message: response.data['message'], results: accounts);
    }  on DioException catch (e) {
      final message = ApiService.errorMessage(e);
      final errors = e.response?.data['errors'];

      return Result(isSuccess: false, message: message, errors: errors);
    } catch (e) {
      return Result(isSuccess: false, message: AppStrings.anErrorOccurredTryAgain);
    }
  }

  static Future<Result<AccountModel>> create(double initialBalance, String name, String currency, String accountType) async {
    try {
      final response = await ApiService.post(ApiRoutes.accountUrl, {
        'account_type': accountType,
        'currency': currency,
        'name': name,
        'initial_balance': initialBalance,
      });

      final results = response.data['results'];
      final account = await AccountService.create(results['account']);

      return Result(isSuccess: true, message: response.data['message'], results: account);
    }  on DioException catch (e) {
      final message = ApiService.errorMessage(e);
      final errors = e.response?.data['errors'];

      return Result(isSuccess: false, message: message, errors: errors);
    } catch (e) {
      return Result(isSuccess: false, message: AppStrings.anErrorOccurredTryAgain);
    }
  }
}
