import 'package:equatable/equatable.dart';

class ResultScanEntity extends Equatable {
  const ResultScanEntity({
    required this.data,
    required this.comment,
    required this.timestamp,
    this.deviceId,
    this.userId,
  });

  final String data;
  final String comment;
  final DateTime timestamp;
  final String? deviceId;
  final String? userId;

  ResultScanEntity copyWith({
    final String? data,
    final String? comment,
    final DateTime? timestamp,
    final String? deviceId,
    final String? userId,
  }) {
    return ResultScanEntity(
      data: data ?? this.data,
      comment: comment ?? this.comment,
      timestamp: timestamp ?? this.timestamp,
      deviceId: deviceId ?? this.deviceId,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    data,
    comment,
    timestamp,
    deviceId,
    userId,
  ];
}
