import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/certificate_model.dart';

class CertificateState {
  final List<CertificateModel> certificates;
  final bool isLoading;
  final String errorMessage;

  const CertificateState({
    this.certificates = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  CertificateState copyWith({
    List<CertificateModel>? certificates,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CertificateState(
      certificates: certificates ?? this.certificates,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class CertificateViewModel extends Notifier<CertificateState> {
  @override
  CertificateState build() {
    Future.microtask(loadCertificates);
    return const CertificateState();
  }

  Future<void> loadCertificates() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        certificates: CertificateModel.getDummyCertificates(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Could not load certificates',
      );
    }
  }
}

final certificateProvider =
    NotifierProvider<CertificateViewModel, CertificateState>(
      CertificateViewModel.new,
    );
