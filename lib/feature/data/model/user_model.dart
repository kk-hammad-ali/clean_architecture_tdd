import 'dart:convert';

import 'package:clean_architecture_tdd/feature/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.avatar,
    required super.id,
    required super.createdAt,
    required super.name,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      avatar: avatar ?? this.avatar,
    );
  }

  const UserModel.empty()
      : this(
          id: 'empty_id',
          name: 'empty_name',
          createdAt: 'empty_createdAt',
          avatar: 'empty_avatar',
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['createdAt'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
