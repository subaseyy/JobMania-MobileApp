part of 'applied_jobs_cubit.dart';

abstract class AppliedJobsState extends Equatable {
  const AppliedJobsState();

  @override
  List<Object> get props => [];
}

class AppliedJobsInitial extends AppliedJobsState {}

class AppliedJobsLoading extends AppliedJobsState {}

class AppliedJobsLoaded extends AppliedJobsState {
  final List<AppliedJobUIModel> appliedJobs;

  const AppliedJobsLoaded({required this.appliedJobs});

  @override
  List<Object> get props => [appliedJobs];
}

class AppliedJobsError extends AppliedJobsState {
  final String message;

  const AppliedJobsError({required this.message});

  @override
  List<Object> get props => [message];
}
