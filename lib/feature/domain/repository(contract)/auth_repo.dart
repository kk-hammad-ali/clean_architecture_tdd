import 'package:clean_architecture_tdd/core/utils/typedef.dart';
import 'package:clean_architecture_tdd/feature/domain/entities/user.dart';

abstract class AuthRepoContract {
  const AuthRepoContract();

  ResultFutureVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<UserEntity>> getUsers();
}
