import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/saved_jobs/domain/entity/saved_job_entity.dart';

part 'saved_job_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.savedJobTableId)
class SavedJobHiveModel extends Equatable {
  @HiveField(0)
  final String savedId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String jobId;

  @HiveField(3)
  final String savedAt;

  SavedJobHiveModel({
    String? savedId,
    required this.userId,
    required this.jobId,
    required this.savedAt,
  }) : savedId = savedId ?? const Uuid().v4();

  factory SavedJobHiveModel.fromEntity(SavedJobEntity entity) {
    return SavedJobHiveModel(
      savedId: entity.savedId,
      userId: entity.userId,
      jobId: entity.jobId,
      savedAt: entity.savedAt,
    );
  }

  SavedJobEntity toEntity() {
    return SavedJobEntity(
      savedId: savedId,
      userId: userId,
      jobId: jobId,
      savedAt: savedAt,
    );
  }

  @override
  List<Object?> get props => [savedId, userId, jobId, savedAt];
}
