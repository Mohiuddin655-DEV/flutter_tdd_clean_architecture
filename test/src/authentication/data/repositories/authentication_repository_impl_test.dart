import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_example/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource source;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    source = MockAuthenticationRemoteDataSource();
    repositoryImpl = AuthenticationRepositoryImpl(source);
  });

  const tException = ApiException(
    message: "Unknown Error Occurred",
    statusCode: 500,
  );

  group("createUser", () {
    const createAt = "whatever.createAt";
    const name = "whatever.name";
    const avatar = "whatever.avatar";

    test(
      "should call the [RemoteDataSource.createUser] and complete successfully when the call to the remote is successful",
      () async {
        // Arrange
        when(() {
          return source.createUser(
            createAt: any(named: "createAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          );
        }).thenAnswer((_) async {
          return Future.value();
        });

        // Act
        final result = await repositoryImpl.createUser(
          createAt: createAt,
          name: name,
          avatar: avatar,
        );
        // Assert
        expect(result, equals(const Right(null)));
        verify(() {
          return source.createUser(
            createAt: createAt,
            name: name,
            avatar: avatar,
          );
        }).called(1);
        verifyNoMoreInteractions(source);
      },
    );
    test(
      "should return a [ServerFailure] when the call to the remote source is unsuccessful",
      () async {
        // Arrange
        when(() {
          return source.createUser(
            createAt: any(named: "createAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          );
        }).thenThrow(tException);

        // Act
        final result = await repositoryImpl.createUser(
          createAt: createAt,
          name: name,
          avatar: avatar,
        );
        // Assert
        expect(result, equals(Left(ApiFailure.fromException(tException))));
        verify(() {
          return source.createUser(
            createAt: createAt,
            name: name,
            avatar: avatar,
          );
        }).called(1);
        verifyNoMoreInteractions(source);
      },
    );
  });

  group("getUsers", () {
    test(
      "should call the [RemoteDataSource.getUsers] and return [List<User>] when call to remote is successful",
      () async {
        // Arrange
        when(() {
          return source.getUsers();
        }).thenAnswer((_) async {
          return [];
        });

        // Act
        final result = await repositoryImpl.getUsers();
        // Assert
        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => source.getUsers()).called(1);
        verifyNoMoreInteractions(source);
      },
    );
    test(
      "should return a [ApiFailure] when the call to the remote source is unsuccessful",
      () async {
        // Arrange
        when(() => source.getUsers()).thenThrow(tException);

        // Act
        final result = await repositoryImpl.getUsers();
        // Assert
        expect(result, equals(Left(ApiFailure.fromException(tException))));
        verify(() {
          return source.getUsers();
        }).called(1);
        verifyNoMoreInteractions(source);
      },
    );
  });
}
