import 'package:hive/hive.dart';
import 'package:penger/models/user.dart';

class AuthService {

  static Future<UserModel> create(Map<String, dynamic> user, String token) async {
    final userBox = await Hive.openBox(UserModel.userBox);
    await userBox.clear();

    var userModel = UserModel();
    userModel.id = user['id'];
    userModel.name = user['name'];
    userModel.email = user['email'];
    userModel.emailVerifiedAt = user['email_verified_at'] != null ? DateTime.parse(user['email_verified_at']) : null;
    userModel.createdAt = DateTime.parse(user['created_at']);
    userModel.updatedAt = DateTime.parse(user['updated_at']);
    userModel.token = token;

    await userBox.put(0, userModel);
    return userModel;
  }

  static Future<UserModel> update(Map<String, dynamic> user) async {
    final userBox = await Hive.openBox(UserModel.userBox);
    if(userBox.isEmpty) throw Exception("User does not exist");

    var userModel = userBox.get(0);
    userModel.id = user['id'] ?? userModel.id;
    userModel.name = user['name'] ?? userModel.name;
    userModel.email = user['email'] ?? userModel.email;
    userModel.emailVerifiedAt = user['email_verified_at'] != null ? DateTime.parse(user['email_verified_at']) :  userModel.emailVerifiedAt;
    userModel.createdAt = user['created_at'] != null ? DateTime.parse(user['created_at']) :  userModel.createdAt;
    userModel.updatedAt = user['updated_at'] != null ? DateTime.parse(user['updated_at']) :  userModel.updatedAt;

    await userBox.put(0, userModel);
    return userModel;
  }

  static Future<UserModel?> get() async {
    final userBox = await Hive.openBox(UserModel.userBox);
    if(userBox.isEmpty) return null;

    final userModel = await userBox.getAt(0);
    return userModel as UserModel?;
  }

  static Future delete() async {
    final userBox = await Hive.openBox(UserModel.userBox);
    await userBox.clear();
  }
}