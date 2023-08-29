import 'package:bloc/bloc.dart';
import 'package:clean_architecture_tdd/feature/domain/entities/user.dart';
import 'package:clean_architecture_tdd/feature/domain/usecases/create_user.dart';
import 'package:clean_architecture_tdd/feature/domain/usecases/get_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CreateUser createUser,
    required GetUsers getUser,
  })  : _createUser = createUser,
        _getUser = getUser,
        super(const AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUser;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        name: event.name,
        createdAt: event.createdAt,
        avatar: event.avatar,
      ),
    );

    result.fold(
      (failure) =>
          emit(AuthError('${failure.statusCode} Error: ${failure.message}')),
      (_) => emit(
        const UserCreated(),
      ),
    );
  }

  Future<void> _getUserHandler(
    GetUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const GettingUser());
    final result = await _getUser();

    result.fold(
      (failure) =>
          emit(AuthError('${failure.statusCode} Error: ${failure.message}')),
      (users) => emit(
        UserLoaded(users),
      ),
    );
  }
}
