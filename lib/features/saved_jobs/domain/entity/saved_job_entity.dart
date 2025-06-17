import 'package:equatable/equatable.dart';

class SavedJobEntity extends Equatable {
  final String savedId;
  final String userId;
  final String jobId;
  final String savedAt;

  const SavedJobEntity({
    required this.savedId,
    required this.userId,
    required this.jobId,
    required this.savedAt,
  });

  @override
  List<Object?> get props => [savedId, userId, jobId, savedAt];
}
