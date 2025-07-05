import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/features/home/domain/use_case/get_few_jobs_usecase.dart';

import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_state.dart';

class DashboardViewModel extends Cubit<DashboardState> {
  final GetFewJobsUseCase getFewJobsUseCase;

  DashboardViewModel({required this.getFewJobsUseCase})
    : super(DashboardState.initial());

  Future<void> loadJobs() async {
    emit(state.copyWith(isLoading: true));
    try {
      final jobs = await getFewJobsUseCase();
      emit(state.copyWith(isLoading: false, jobs: jobs));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
