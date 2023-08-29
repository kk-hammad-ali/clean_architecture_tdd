import 'package:clean_architecture_tdd/core/usecases/usecaes.dart';
import 'package:clean_architecture_tdd/core/utils/typedef.dart';
import 'package:clean_architecture_tdd/feature/domain/repository(contract)/auth_repo.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repoContract);

  final AuthRepoContract _repoContract;

  @override
  ResultFutureVoid call(params) async => _repoContract.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String name;
  final String createdAt;
  final String avatar;

  const CreateUserParams({
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
          name: 'name',
          createdAt: 'createdAt',
          avatar: 'avatar',
        );

  @override
  List<Object?> get props => [name, createdAt, avatar];
}
