import 'package:flutter/material.dart';
import '../../domain/entity/job_entity.dart';
import '../../domain/use_case/get_all_jobs_use_case.dart';

class JobViewModel extends ChangeNotifier {
  final GetAllJobsUseCase getAllJobsUseCase;

  final ValueNotifier<List<JobPostEntity>> jobs = ValueNotifier([]);
  final ScrollController scrollController = ScrollController();

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchTerm = '';
  Map<String, dynamic> _filters = {};

  JobViewModel({required this.getAllJobsUseCase}) {
    scrollController.addListener(_onScroll);
  }

  void init() {
    fetchJobs(reset: true);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      fetchJobs();
    }
  }

  Future<void> fetchJobs({bool reset = false}) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    if (reset) {
      _page = 1;
      _hasMore = true;
      jobs.value = [];
    }

    final fetched = await getAllJobsUseCase(
      page: _page,
      limit: 10,
      search: _searchTerm,
      filters: _filters,
    );

    if (fetched.isEmpty) {
      _hasMore = false;
    } else {
      jobs.value = [...jobs.value, ...fetched];
      _page++;
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchJobs(String search) {
    _searchTerm = search;
    fetchJobs(reset: true);
  }

  void applyFilters(Map<String, dynamic> filters) {
    _filters = filters;
    fetchJobs(reset: true);
  }

  bool get isLoadingMore => _isLoading && _page > 1;

  void refresh() {}
}
