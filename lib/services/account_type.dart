import 'package:hive/hive.dart';
import 'package:penger/models/account_type.dart';

class AccountTypeService {

  static Future<AccountTypeModel> create(Map<String, dynamic> accountType) async {
    final accountTypeBox = await Hive.openBox(AccountTypeModel.accountTypeBox);

    var accountTypeModel = AccountTypeModel.fromMap(accountType);

    await accountTypeBox.put(accountTypeModel.id, accountTypeModel);
    return accountTypeModel;
  }

  static Future<List<AccountTypeModel>> createAccountTypes(List accountTypes) async {
    final accountTypeBox = await Hive.openBox(AccountTypeModel.accountTypeBox);
    await accountTypeBox.clear();

    List<AccountTypeModel> accountTypeModels = [];

    for(var accountType in accountTypes){
      var accountTypeModel = AccountTypeModel.fromMap(accountType);

      await accountTypeBox.put(accountTypeModel.id, accountTypeModel);
      accountTypeModels.add(accountTypeModel);
    }

    return accountTypeModels;
  }
}