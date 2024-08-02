
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class UserModel{
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String email;

  @HiveField(3)
  DateTime? emailVerifiedAt;

  @HiveField(4)
  late DateTime createdAt;

  @HiveField(5)
  late DateTime updatedAt;

  @HiveField(6)
  late String token;

  @HiveField(7)
  String? pin;

  static String userBox = 'users';
}