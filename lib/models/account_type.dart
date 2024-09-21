import 'package:hive/hive.dart';

part 'account_type.g.dart';

@HiveType(typeId: 3)
class AccountTypeModel {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String code;

  @HiveField(3)
  late String description;

  static String accountTypeBox = 'account_types';

  static AccountTypeModel fromMap(Map<String, dynamic> accountType) {
    var accountTypeModel = AccountTypeModel();
    accountTypeModel.id = accountType['id'];
    accountTypeModel.name = accountType['name'];
    accountTypeModel.code = accountType['code'];
    accountTypeModel.description = accountType['description'];

    return accountTypeModel;
  }

  bool isEqual(AccountTypeModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
