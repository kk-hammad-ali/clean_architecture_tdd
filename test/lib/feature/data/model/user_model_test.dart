// What does the class depend on (Needs of constructors)
// How can we create of that dependency
// How do we control what the dependency do

import 'dart:convert';

import 'package:clean_architecture_tdd/feature/data/model/user_model.dart';
import 'package:clean_architecture_tdd/feature/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const tModel = UserModel.empty();
  final tJson = fixtures("user.json");
  final tMap = jsonDecode(tJson);
  test('should be a subclass of User[Entity]', () {
    expect(tModel, isA<UserEntity>());
  });

  group('form map', () {
    test('should return a [UserModel] with correct data', () {
      final result = UserModel.fromMap(tMap);

      expect(result, equals(tModel));
    });
  });
  group('form Json', () {
    test('should return a [UserModel] with correct data', () {
      final result = UserModel.fromJson(tJson);

      expect(result, equals(tModel));
    });
  });

  group('to Map', () {
    test('should return a [Map] with correct data', () {
      final result = tModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('to Json', () {
    test('should return a [Jsom] with correct data', () {
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "empty_id",
        "name": "empty_name",
        "createdAt": "empty_createdAt",
        "avatar": "empty_avatar"
      });
      expect(result, equals(tJson));
    });
  });

  group('copy with', () {
    test('should return a [UserModel] with different data', () {
      final result = tModel.copyWith(name: 'kk');

      expect(result.name, equals('kk'));
      expect(result.name, equals('kk'));
    });
  });
}
