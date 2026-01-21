import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    super.email,
    super.name,
    super.surname = '',
    super.birthdate = '',
  });

  factory UserModel.fromFirestore({required final Map<String, dynamic> data}) =>
      UserModel(
        uid: data['uid']?.toString() ?? '',
        email: data['email']?.toString() ?? '',
        name: data['name']?.toString() ?? '',
        surname: data['surname']?.toString() ?? '',
        birthdate: data['birthdate']?.toString() ?? '',
      );

  factory UserModel.fromFirebaseUser(final User user) {
    /// Extract name and surname from Google account
    final String fullName =
        user.displayName ?? user.email?.split('@').first ?? '';
    final List<String> nameParts = fullName.split(' ');

    final String name = nameParts.isNotEmpty ? nameParts.first : '';
    final String surname = nameParts.length > 1
        ? nameParts.sublist(1).join(' ')
        : '';

    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: name,
      surname: surname,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uid': uid ?? '',
    'email': email ?? '',
    'name': name ?? '',
    'surname': surname ?? '',
    'birthdate': birthdate ?? '',
  };

  @override
  UserModel copyWith({
    final String? uid,
    final String? name,
    final String? surname,
    final String? email,
    final String? birthdate,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,
    );
  }
}
