import 'dart:convert';

import 'package:clean_architecture_tdd/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd/core/utils/constant.dart';
import 'package:clean_architecture_tdd/feature/data/datasource/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd/feature/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource authRemoteDataSourceImplementation;
  registerFallbackValue(Uri());

  setUp(() {
    client = MockClient();
    authRemoteDataSourceImplementation =
        AuthRemoteDataSourceImplementation(client);
  });

  group('createUser', () {
    test('should complete successfully with statusCode 201 or 200', () async {
      // Mocking the HTTP response
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User Created Successfully', 201));

      final methodCall = authRemoteDataSourceImplementation.createUser;

      expect(
        methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.parse('$kBaseURL$kCreateUserEndPoint'),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throws an [APIException] when status code is wrong', () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response(
          'Invalid Request',
          400,
        ),
      );

      final methodCall = authRemoteDataSourceImplementation.createUser;

      expect(
        () async => methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        throwsA(
          const APIException(message: 'Invalid Request', statusCode: 400),
        ),
      );

      verify(
        () => client.post(
          Uri.parse('$kBaseURL$kCreateUserEndPoint'),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
  group('getUsers', () {
    final tUsers = [
      const UserModel.empty(),
    ];
    test('should complete successfully with statusCode 201 or 200', () async {
      // Mocking the HTTP response
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
          jsonEncode(
            [
              tUsers.first.toMap(),
            ],
          ),
          200,
        ),
      );

      final result = await authRemoteDataSourceImplementation.getUsers();

      expect(
        result,
        equals(tUsers),
      );

      verify(
        () => client.get(
          Uri.parse('$kBaseURL$kGetUsersEndPoint'),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
      'should throws an [APIException] when status code is wrong',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(('Server down')), 500),
        );
        final methodCall = authRemoteDataSourceImplementation.getUsers;

        expect(
          () => methodCall(),
          throwsA(
            const APIException(message: 'Server down', statusCode: 500),
          ),
        );

        verify(
          () => client.get(
            Uri.parse('$kBaseURL$kGetUsersEndPoint'),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
