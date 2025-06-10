import 'package:flutter/foundation.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/data/repositories/local/user_repository.dart';

class UsersProvider with ChangeNotifier {
  List<UserModel> _users = [];
  final UserRepository _userRepository = UserRepository();
  Stream<List<UserModel>>? _usersStream;

  List<UserModel> get users => _users;

  UsersProvider() {
    _initializeUsersStream();
  }

  void _initializeUsersStream() {
    _usersStream = _userRepository.streamUsers();
    _usersStream?.listen((updatedUsers) {
      _users = updatedUsers;
      notifyListeners();
    });
  }

  void dispose() {
    _usersStream = null;
    super.dispose();
  }

  void setUsers(List<UserModel> users) {
    _users = users;
    notifyListeners();
  }

  void addUser(UserModel user) {
    _users.add(user);
    notifyListeners();
  }
}
