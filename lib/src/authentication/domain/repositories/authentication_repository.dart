import '../../../../index.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
