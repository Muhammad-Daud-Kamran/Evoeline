// lib/viewmodels/agenda_viewmodel.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// ViewModel for Agenda section in Screen 31
// Handles only the timeline and session data
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/agenda_item_model.dart';

class AgendaState {
  final List<AgendaItemModel> items;
  final bool isLoading;

  const AgendaState({
    this.items = const [],
    this.isLoading = false,
  });

  AgendaState copyWith({
    List<AgendaItemModel>? items,
    bool? isLoading,
  }) {
    return AgendaState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AgendaViewModel extends StateNotifier<AgendaState> {
  AgendaViewModel() : super(const AgendaState(isLoading: true)) {
    loadAgenda();
  }

  Future<void> loadAgenda() async {
    state = state.copyWith(isLoading: true);
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    state = state.copyWith(
      items: _getDummyAgenda(),
      isLoading: false,
    );
  }

  List<AgendaItemModel> _getDummyAgenda() {
    return const [
      AgendaItemModel(
        agendaId: 'A001',
        title: 'Opening Keynote',
        time: '10:00 AM - 11:00 AM',
        description: 'Welcome address and keynote speech',
        speakerId: 'SPK001',
        isLast: false,
      ),
      AgendaItemModel(
        agendaId: 'A002',
        title: 'Panel Discussion: Future of AI',
        time: '11:30 AM - 12:30 PM',
        description: 'Industry leaders discuss AI trends',
        speakerId: 'SPK002',
        isLast: false,
      ),
      AgendaItemModel(
        agendaId: 'A003',
        title: 'Networking Lunch',
        time: '12:30 PM - 1:30 PM',
        description: 'Connect with fellow attendees',
        speakerId: '',
        isLast: true,
      ),
    ];
  }
}

final agendaProvider = StateNotifierProvider<AgendaViewModel, AgendaState>((ref) {
  return AgendaViewModel();
});
