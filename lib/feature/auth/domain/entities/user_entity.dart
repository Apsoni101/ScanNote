import 'package:equatable/equatable.dart';

/// Entity of user for only showing or exposing required properties that's used
class UserEntity extends Equatable {
  /// Creates an instance of userEntity
  const UserEntity({
    this.uid,
    this.email,
    this.name,
    this.birthdate,
    this.surname,
  });

  /// Unique user id
  final String? uid;

  /// User name
  final String? name;

  /// User surname
  final String? surname;

  /// User email
  final String? email;

  /// User birthdate
  final String? birthdate;

  @override
  List<Object?> get props => <Object?>[uid, email, name, surname, birthdate];

  /// Copy with method for entity
  UserEntity copyWith({
    final String? uid,
    final String? name,
    final String? surname,
    final String? email,
    final String? birthdate,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,
    );
  }
}
