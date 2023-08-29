import 'package:clean_architecture_tdd/core/usecases/usecaes.dart';
import 'package:clean_architecture_tdd/core/utils/typedef.dart';
import 'package:clean_architecture_tdd/feature/domain/entities/user.dart';
import 'package:clean_architecture_tdd/feature/domain/repository(contract)/auth_repo.dart';

class GetUsers extends UseCaseWithoutParams<List<UserEntity>> {
  const GetUsers(this._repoContract);

  final AuthRepoContract _repoContract;

  @override
  ResultFuture<List<UserEntity>> call() async => _repoContract.getUsers();
}
