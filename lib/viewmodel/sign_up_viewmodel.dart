import 'package:blog/data/repositories/local/user_repository.dart';

class SignUpViewModel {
  createUser(String username, String email, String password) async {
    await UserRepository().createUser(username, email, password);
  }
}
