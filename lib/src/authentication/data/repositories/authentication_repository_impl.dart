import 'package:dartz/dartz.dart';

import '../../../../index.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _source;

  const AuthenticationRepositoryImpl(this._source);

  @override
  ResultVoid createUser({
    required String createAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _source.createUser(createAt: createAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _source.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
