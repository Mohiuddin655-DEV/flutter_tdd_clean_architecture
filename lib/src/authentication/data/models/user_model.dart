import 'dart:convert';

import 'package:flutter_app_navigator/app_navigator.dart';

import '../../../../index.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty()
      : this(
          id: "1",
          createAt: "_empty.createAt",
          name: "_empty.name",
          avatar: "_empty.avatar",
        );

  UserModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map("id", ""),
          createAt: map("createAt", ""),
          name: map("name", ""),
          avatar: map("avatar", ""),
        );

  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(jsonDecode(source));
  }

  UserModel copyWith({
    String? id,
    String? createAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  DataMap toMap() {
    return {
      "id": id,
      "avatar": avatar,
      "createAt": createAt,
      "name": name,
    };
  }

  String toJson() => jsonEncode(toMap());
}
