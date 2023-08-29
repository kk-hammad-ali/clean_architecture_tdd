// What does the class depend on (Needs of constructors)
// How can we create of that dependency
// How do we control what the dependency do

import 'package:clean_architecture_tdd/feature/domain/repository(contract)/auth_repo.dart';
import 'package:clean_architecture_tdd/feature/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepoContract {}

void main() {
  late CreateUser usecase;
  late AuthRepoContract repoContract;

  setUp(() {
    repoContract = MockAuthRepo();
    usecase = CreateUser(repoContract);
  });
  const param = CreateUserParams.empty();
  test('should call [Auth.createUser]', () async {
    // arrange -- everthing required
    when(
      () => repoContract.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(param);

    //assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repoContract.createUser(
        avatar: param.avatar,
        createdAt: param.createdAt,
        name: param.name,
      ),
    ).called(1);

    verifyNoMoreInteractions(repoContract);
  });
}
