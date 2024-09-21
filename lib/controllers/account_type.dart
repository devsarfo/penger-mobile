import 'package:dio/dio.dart';
import 'package:penger/models/account_type.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/services/account_type.dart';
import 'package:penger/services/api.dart';
import 'package:penger/services/api_routes.dart';
import 'package:penger/models/result.dart';

class AccountTypeController {
  static Future<Result<List<AccountTypeModel>>> load() async {
    try {
      final response = await ApiService.get(ApiRoutes.accountTypeUrl, {});

      final results = response.data['results'];
      final accountTypes = await AccountTypeService.createAccountTypes(results['account_types']);

      return Result(isSuccess: true, message: response.data['message'], results: accountTypes);
    }  on DioException catch (e) {
      final message = ApiService.errorMessage(e);
      final errors = e.response?.data['errors'];

      return Result(isSuccess: false, message: message, errors: errors);
    } catch (e) {
      return Result(isSuccess: false, message: AppStrings.anErrorOccurredTryAgain);
    }
  }
}
