import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tdd_example/index.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test("should call the [AuthRepository.createUser", () async {
    // Arrange
    when(() {
      return repository.createUser(
        createAt: any(named: "createAt"),
        name: any(named: "name"),
        avatar: any(named: "avatar"),
      );
    }).thenAnswer((_) async {
      return const Right(null);
    });

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() {
      return repository.createUser(
        createAt: params.createAt,
        name: params.name,
        avatar: params.avatar,
      );
    }).called(1);
    verifyNoMoreInteractions(repository);
  });
}
