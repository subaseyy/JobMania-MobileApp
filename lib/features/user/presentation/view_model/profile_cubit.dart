import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:jobmaniaapp/features/user/domain/use_case/get_profile_use_case.dart';

class ProfileCubit extends Cubit<ProfileEntity?> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(this.getProfileUseCase) : super(null);

  Future<void> loadProfile(String userId) async {
    try {
      final profile = await getProfileUseCase(userId);
      emit(profile);
    } catch (e) {
      emit(null);
    }
  }
}
