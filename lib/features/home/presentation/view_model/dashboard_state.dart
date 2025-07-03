import 'package:equatable/equatable.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final List<JobPostEntity> jobs;
  final String error;

  const DashboardState({
    required this.isLoading,
    required this.jobs,
    required this.error,
  });

  factory DashboardState.initial() =>
      const DashboardState(isLoading: false, jobs: [], error: '');

  DashboardState copyWith({
    bool? isLoading,
    List<JobPostEntity>? jobs,
    String? error,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, jobs, error];
}
