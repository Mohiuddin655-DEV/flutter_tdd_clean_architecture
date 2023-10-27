import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tdd_example/index.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test(
    "should call [AuthRepository.getUsers] and return [List<User>]",
    () async {
      // Arrange
      when(() {
        return repository.getUsers();
      }).thenAnswer((_) async {
        return const Right(tResponse);
      });
      // Act
      final result = await usecase();
      // Assert
      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
      verify(() {
        return repository.getUsers();
      }).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
