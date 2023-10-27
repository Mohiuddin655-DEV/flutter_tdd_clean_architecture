import 'dart:convert';

import 'package:flutter_tdd_example/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client client;
  late AuthenticationRemoteDataSource source;

  setUp(() {
    client = MockClient();
    source = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group("createUser", () {
    test(
      "should complete successfully when the status code is 200 or 201",
      () async {
        when(() {
          return client.post(any(), body: any(named: "body"));
        }).thenAnswer((_) async {
          return Response("User created successfully", 201);
        });

        final methodCall = source.createUser;

        expect(
          methodCall(
            createAt: "createAt",
            name: "name",
            avatar: "avatar",
          ),
          completes,
        );

        verify(() {
          return client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              "createAt": "createAt",
              "name": "name",
              "avatar": "avatar",
            }),
          );
        }).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      "should throw [ApiException] when the status code is 200 or 201",
      () async {
        when(() {
          return client.post(any(), body: any(named: "body"));
        }).thenAnswer((_) async {
          return Response("Invalid email address", 400);
        });

        final methodCall = source.createUser;

        expect(
          () => methodCall(
            createAt: "createAt",
            name: "name",
            avatar: "avatar",
          ),
          throwsA(const ApiException(
            message: "Invalid email address",
            statusCode: 400,
          )),
        );

        verify(() {
          return client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              "createAt": "createAt",
              "name": "name",
              "avatar": "avatar",
            }),
          );
        }).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group("getUsers", () {
    const tUsers = [UserModel.empty()];
    test(
      "should return [List<User>] when the status code is 200",
      () async {
        when(() => client.get(any())).thenAnswer((_) async {
          return Response(jsonEncode([tUsers.first.toMap()]), 200);
        });

        final result = await source.getUsers();

        expect(result, equals(tUsers));

        verify(() {
          return client.get(Uri.https(kBaseUrl, kGetUsersEndpoint));
        }).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      "should throw [ApiException] when the status code is not 200",
      () async {
        const tMessage = 'Server down';

        when(() => client.get(any())).thenAnswer((_) async {
          return Response(tMessage, 500);
        });

        final methodCall = source.getUsers;

        expect(
          () => methodCall(),
          throwsA(const ApiException(
            message: tMessage,
            statusCode: 500,
          )),
        );

        verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
            .called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
