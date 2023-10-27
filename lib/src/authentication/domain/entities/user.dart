import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String createAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
          id: "1",
          createAt: "_empty.createAt",
          name: "_empty.name",
          avatar: "_empty.avatar",
        );

  @override
  List<Object?> get props => [id, name, avatar];
}
