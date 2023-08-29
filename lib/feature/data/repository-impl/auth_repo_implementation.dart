import 'package:clean_architecture_tdd/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd/core/errors/failure.dart';
import 'package:clean_architecture_tdd/core/utils/typedef.dart';
import 'package:clean_architecture_tdd/feature/data/datasource/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd/feature/domain/entities/user.dart';
import 'package:clean_architecture_tdd/feature/domain/repository(contract)/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoContractImplementation implements AuthRepoContract {
  final AuthRemoteDataSource _remoteDataSource;
  const AuthRepoContractImplementation(this._remoteDataSource);

  @override
  ResultFutureVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // TDD
    // call the remote data source
    // check if method return the proper data
    // // check if when the romote data throw exception we return a failure otherwise data

    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<UserEntity>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
