// What does the class depend on (Needs of constructors)
// How can we create of that dependency
// How do we control what the dependency do

import 'package:clean_architecture_tdd/feature/domain/entities/user.dart';
import 'package:clean_architecture_tdd/feature/domain/repository(contract)/auth_repo.dart';
import 'package:clean_architecture_tdd/feature/domain/usecases/get_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepoContract {}

void main() {
  late GetUsers usecase;
  late AuthRepoContract repoContract;

  setUp(() {
    repoContract = MockAuthRepo();
    usecase = GetUsers(repoContract);
  });

  final tResponse = [
    const UserEntity.empty(),
    const UserEntity.empty(),
    const UserEntity.empty(),
    const UserEntity.empty(),
  ];

  test('should call [Auth.getUsers] and return List<UserEntity>]', () async {
    // arrange -- everthing required
    when(
      () => repoContract.getUsers(),
    ).thenAnswer(
      (_) async => Right(tResponse),
    );

    // act
    final result = await usecase();

    //assert
    expect(result, equals(Right<dynamic, List<UserEntity>>(tResponse)));
    verify(() => repoContract.getUsers()).called(1);

    verifyNoMoreInteractions(repoContract);
  });
}
