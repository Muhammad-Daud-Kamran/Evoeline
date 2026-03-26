// lib/viewmodels/speaker_viewmodel.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/speaker_model.dart';

class SpeakerState {
  final List<SpeakerModel> speakers; // Changed to list to support multiple speakers in UI
  final bool isLoading;
  final String errorMessage;

  const SpeakerState({
    this.speakers = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  SpeakerState copyWith({
    List<SpeakerModel>? speakers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SpeakerState(
      speakers: speakers ?? this.speakers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Helper to get a single speaker for Screen 30 compatibility
  SpeakerModel get speaker => speakers.isNotEmpty ? speakers.first : SpeakerModel.empty();
}

class SpeakerViewModel extends StateNotifier<SpeakerState> {
  SpeakerViewModel()
      : super(const SpeakerState(isLoading: true)) {
    loadSpeakers();
  }

  Future<void> loadSpeakers() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      state = state.copyWith(
        speakers: _getDummySpeakers(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load speakers.',
      );
    }
  }

  List<SpeakerModel> _getDummySpeakers() {
    return const [
      SpeakerModel(
        speakerId: 'SPK001',
        name: 'Ethan Carter',
        designation: 'CEO, TechCorp',
        profileImage: 'assets/images/screen31circularimage1.jpg',
      ),
      SpeakerModel(
        speakerId: 'SPK002',
        name: 'Sophia Bennett',
        designation: 'CTO, InnovateAI',
        profileImage: 'assets/images/screen31circularimage2.jpg',
      ),
      SpeakerModel(
        speakerId: 'SPK003',
        name: 'Liam',
        designation: 'Future..',
        profileImage: 'assets/images/screen31circularimage3.png',
      ),
    ];
  }
}

final speakerProvider = StateNotifierProvider<SpeakerViewModel, SpeakerState>((ref) {
  return SpeakerViewModel();
});
