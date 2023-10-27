import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tdd_example/index.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test("should be a subclass of [User] empty", () async {
    // Arrange
    // Act
    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson) as DataMap;

  group("fromMap", () {
    test("should return a [UserModel] with the right data", () {
      // Act
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    test("should return a [UserModel] with the right data", () {
      // Act
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("should return a [Map] with the right data", () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group("toMap", () {
    test("should return a [Map] with the right data", () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test("should return a [JSON] with the right data", () {
      // Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createAt": "_empty.createAt",
        "name": "_empty.name"
      });

      // Assert
      expect(result, equals(tJson));
    });
  });

  group("copyWith", () {
    test("should return a [UserModel] with different data", () {
      // Act
      final result = tModel.copyWith(name: "Poul");

      // Assert
      expect(result.name, equals("Poul"));
    });
  });
}
