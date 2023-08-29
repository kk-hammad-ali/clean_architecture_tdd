import 'dart:convert';

import 'package:clean_architecture_tdd/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd/core/utils/constant.dart';
import 'package:clean_architecture_tdd/core/utils/typedef.dart';
import 'package:clean_architecture_tdd/feature/data/model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndPoint = "/user";
const kGetUsersEndPoint = "/users";

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final http.Client _client;
  const AuthRemoteDataSourceImplementation(this._client);
  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // check to make sure it return right data when called to server either 200 or 201
    // check it return proper data on success
    // check to make sure that it throws a custom exception with right message when wrong

    try {
      final response = await _client.post(
        Uri.parse('$kBaseURL$kCreateUserEndPoint'),
        body: jsonEncode(
          {
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseURL$kGetUsersEndPoint'),
      );

      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      } else {
        return List<DataMap>.from(jsonDecode(response.body) as List)
            .map(
              (userData) => UserModel.fromMap(userData),
            )
            .toList();
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
