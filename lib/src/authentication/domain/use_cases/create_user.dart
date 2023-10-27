import 'package:equatable/equatable.dart';

import '../../../../index.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;

  const CreateUser(this._repository);

  @override
  ResultFuture<void> call(CreateUserParams params) {
    return _repository.createUser(
      createAt: params.createAt,
      name: params.name,
      avatar: params.avatar,
    );
  }
}

class CreateUserParams extends Equatable {
  final String createAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
          createAt: "_empty.createAt",
          name: "_empty.name",
          avatar: "_empty.avatar",
        );

  @override
  List<Object?> get props => [createAt, name, avatar];
}
