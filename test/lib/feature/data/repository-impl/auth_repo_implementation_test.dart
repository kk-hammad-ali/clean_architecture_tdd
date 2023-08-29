// What does the class depend on (Needs of constructors)
// How can we create of that dependency
// How do we control what the dependency do

import 'package:clean_architecture_tdd/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd/core/errors/failure.dart';
import 'package:clean_architecture_tdd/feature/data/datasource/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd/feature/data/model/user_model.dart';
import 'package:clean_architecture_tdd/feature/data/repository-impl/auth_repo_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource authRemoteDataSource;
  late AuthRepoContractImplementation authRepoContractImplementation;

  setUp(() {
    authRemoteDataSource = MockAuthRemoteDataSource();
    authRepoContractImplementation =
        AuthRepoContractImplementation(authRemoteDataSource);
  });

  group('createUser', () {
    const createdAt = 'test_createdAt';
    const name = 'test_name';
    const avatar = 'test_avatar';
    test(
        'should call the [RemoteDatasource.createUser] to create a [User] & return a proper data ',
        () async {
      // arange

      when(
        () => authRemoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await authRepoContractImplementation.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // assert
      // remote source get call with correct data & is called with right data

      expect(result, equals(const Right(null)));

      verify(
        () => authRemoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);

      verifyNoMoreInteractions(authRemoteDataSource);
    });

    test('should return  [ServerFailure]', () async {
      when(
        () => authRemoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(
        const APIException(
          message: 'Unknow error occured',
          statusCode: 500,
        ),
      );
      final result = await authRepoContractImplementation.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      expect(
        result,
        const Left(
          APIFailure(
            message: 'Unknow error occured',
            statusCode: 500,
          ),
        ),
      );

      verify(
        () => authRemoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      );
      verifyNoMoreInteractions(authRemoteDataSource);
    });
  });

  group('getUsers', () {
    const userList = [
      UserModel.empty(),
      UserModel.empty(),
      UserModel.empty(),
      UserModel.empty(),
    ];

    test('should call the [RemoteDatasource.getUsers] a return a [List<User>]',
        () async {
      when(
        () => authRemoteDataSource.getUsers(),
      ).thenAnswer(
        (_) => Future.value(userList),
      );

      final result = await authRepoContractImplementation.getUsers();

      expect(
        result,
        equals(
          const Right(userList),
        ),
      );

      verify(() => authRemoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(authRemoteDataSource);
    });

    test('should must return a [Failure] ', () async {
      when(() => authRemoteDataSource.getUsers()).thenThrow(
        const APIException(
          message: 'Unknow error occured',
          statusCode: 500,
        ),
      );

      final result = await authRepoContractImplementation.getUsers();

      expect(
        result,
        equals(
          const Left(
            APIFailure(
              message: 'Unknow error occured',
              statusCode: 500,
            ),
          ),
        ),
      );

      verify(() => authRemoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(authRemoteDataSource);
    });
  });
}
