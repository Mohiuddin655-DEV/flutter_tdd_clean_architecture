part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String createAt;
  final String name;
  final String avatar;

  const CreateUserEvent({
    required this.createAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [createAt, name, avatar];
}

class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
