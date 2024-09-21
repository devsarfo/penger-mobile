import 'package:hive/hive.dart';
import 'package:penger/models/account_type.dart';
import 'package:penger/models/currency.dart';

part 'account.g.dart';

@HiveType(typeId: 4)
class AccountModel {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late double initialBalance;

  @HiveField(3)
  late String initialBalanceText;

  @HiveField(4)
  late double currentBalance;

  @HiveField(5)
  late String currentBalanceText;

  @HiveField(6)
  String? colourCode;

  @HiveField(7)
  late int active;

  @HiveField(8)
  late CurrencyModel currency;

  @HiveField(9)
  late AccountTypeModel accountType;

  static String accountBox = 'accounts';

  static AccountModel fromMap(Map<String, dynamic> accountType) {
    var accountModel = AccountModel();
    accountModel.id = accountType['id'];
    accountModel.name = accountType['name'];
    accountModel.initialBalance = double.parse(accountType['initial_balance'].toString());
    accountModel.initialBalanceText = accountType['initial_balance_text'];
    accountModel.currentBalance = double.parse(accountType['current_balance'].toString());
    accountModel.currentBalanceText = accountType['current_balance_text'];
    accountModel.colourCode = accountType['colour_code'];
    accountModel.active = accountType['active'];
    accountModel.currency = CurrencyModel.fromMap(accountType['currency']);
    accountModel.accountType = AccountTypeModel.fromMap(accountType['account_type']);

    return accountModel;
  }

  bool isEqual(AccountModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
