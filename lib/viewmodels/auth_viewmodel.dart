import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String errorMessage;

  const AuthState({this.user, this.isLoading = false, this.errorMessage = ''});

  AuthState copyWith({UserModel? user, bool? isLoading, String? errorMessage}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthViewModel extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Dummy user data
      final dummyUser = UserModel.dummy();

      state = state.copyWith(user: dummyUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Login failed. Please check credentials.',
      );
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      await Future.delayed(const Duration(seconds: 1));
      final dummyUser = UserModel(
        uid: 'new_u_001',
        fullName: name,
        email: email,
        profileImageUrl: 'https://i.pravatar.cc/150?img=12',
      );
      state = state.copyWith(user: dummyUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Sign up failed.');
    }
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider = NotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);
