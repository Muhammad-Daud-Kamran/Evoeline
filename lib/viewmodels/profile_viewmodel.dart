import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

class ProfileState {
  final UserModel? profileInfo;
  final bool isLoading;
  final String errorMessage;
  final bool isSaving;

  const ProfileState({
    this.profileInfo,
    this.isLoading = false,
    this.errorMessage = '',
    this.isSaving = false,
  });

  ProfileState copyWith({
    UserModel? profileInfo,
    bool? isLoading,
    String? errorMessage,
    bool? isSaving,
  }) {
    return ProfileState(
      profileInfo: profileInfo ?? this.profileInfo,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class ProfileViewModel extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    Future.microtask(loadProfile);
    return const ProfileState();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      state = state.copyWith(profileInfo: UserModel.dummy(), isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load profile',
      );
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    state = state.copyWith(isSaving: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(profileInfo: updatedUser, isSaving: false);
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'Failed to save profile',
      );
    }
  }
}

final profileProvider = NotifierProvider<ProfileViewModel, ProfileState>(
  ProfileViewModel.new,
);
