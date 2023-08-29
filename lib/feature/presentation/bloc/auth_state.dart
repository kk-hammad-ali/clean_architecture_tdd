part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

class CreatingUser extends AuthState {
  const CreatingUser();
}

class GettingUser extends AuthState {
  const GettingUser();
}

class UserCreated extends AuthState {
  const UserCreated();
}

class UserLoaded extends AuthState {
  const UserLoaded(this.users);

  final List<UserEntity> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
