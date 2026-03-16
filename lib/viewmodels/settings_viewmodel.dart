import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool isDarkMode;
  final bool isLoading;

  const SettingsState({
    this.pushNotificationsEnabled = true,
    this.emailNotificationsEnabled = false,
    this.isDarkMode = false,
    this.isLoading = false,
  });

  SettingsState copyWith({
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? isDarkMode,
    bool? isLoading,
  }) {
    return SettingsState(
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SettingsViewModel extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    Future.microtask(loadSettings);
    return const SettingsState();
  }

  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulated loaded preferences
    state = state.copyWith(
      pushNotificationsEnabled: true,
      emailNotificationsEnabled: false,
      isDarkMode: false,
      isLoading: false,
    );
  }

  void togglePushNotifications(bool value) {
    state = state.copyWith(pushNotificationsEnabled: value);
    // In real app, save to SharedPreferences/Backend here
  }

  void toggleEmailNotifications(bool value) {
    state = state.copyWith(emailNotificationsEnabled: value);
  }

  void toggleDarkMode(bool value) {
    state = state.copyWith(isDarkMode: value);
  }
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingsState>(
  SettingsViewModel.new,
);
