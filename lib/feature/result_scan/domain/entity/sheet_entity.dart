import 'package:equatable/equatable.dart';

class SheetEntity extends Equatable {
  const SheetEntity({
    required this.id,
    required this.title,
    this.createdTime,
    this.modifiedTime,
  });

  final String id;
  final String title;
  final String? createdTime;
  final String? modifiedTime;

  @override
  List<Object?> get props => <Object?>[id, title, createdTime, modifiedTime];
}
