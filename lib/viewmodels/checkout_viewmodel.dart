import 'package:flutter_riverpod/legacy.dart';
import '../models/registration_models/pricing_tier_model.dart';

// Represents a ticket option available for purchase on the Checkout screen
class TicketOption {
  final String name;
  final String description;
  final double price;
  final int availableSeats;
  final String? availableUntil;

  const TicketOption({
    required this.name,
    required this.description,
    required this.price,
    required this.availableSeats,
    this.availableUntil,
  });

  // Build from existing PricingTierModel (bridges to the existing model)
  factory TicketOption.fromTier(PricingTierModel tier) {
    return TicketOption(
      name: tier.name,
      description: 'Ticket: ${tier.name}',
      price: tier.price.toDouble(),
      availableSeats: tier.seats,
      availableUntil: tier.availableUntil.isNotEmpty ? tier.availableUntil : null,
    );
  }
}

// A payment method option shown on the Checkout screen
class PaymentMethodOption {
  final String name;
  final String subtitle;

  const PaymentMethodOption({required this.name, required this.subtitle});
}

class CheckoutState {
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;

  // Ticket selection
  final List<TicketOption> tickets;
  final String selectedTicketName;
  final int quantity;

  // Promo code
  final String? promoCode;
  final bool promoApplied;
  final double discountAmount;

  // Payment method
  final List<PaymentMethodOption> paymentMethods;
  final String selectedPaymentMethod;

  // Billing
  final String? selectedCountry;

  const CheckoutState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.tickets = const [],
    this.selectedTicketName = '',
    this.quantity = 1,
    this.promoCode,
    this.promoApplied = false,
    this.discountAmount = 0.0,
    this.paymentMethods = const [],
    this.selectedPaymentMethod = '',
    this.selectedCountry,
  });

  // Computed values
  double get ticketPrice {
    final t = tickets.firstWhere(
      (t) => t.name == selectedTicketName,
      orElse: () => tickets.isNotEmpty ? tickets.first : const TicketOption(name: '', description: '', price: 0, availableSeats: 0),
    );
    return t.price;
  }

  double get subtotal => ticketPrice * quantity;
  double get serviceFee => subtotal * 0.05; // 5% service fee
  double get total => subtotal - discountAmount + serviceFee;

  String get subtotalText => '\$${subtotal.toStringAsFixed(2)}';
  String get discountText => '-\$${discountAmount.toStringAsFixed(2)}';
  String get serviceFeeText => '\$${serviceFee.toStringAsFixed(2)}';
  String get totalText => '\$${total.toStringAsFixed(2)}';
  String get ticketLabel => 'Ticket Price x $quantity';

  CheckoutState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    String? successMessage,
    List<TicketOption>? tickets,
    String? selectedTicketName,
    int? quantity,
    String? promoCode,
    bool? promoApplied,
    double? discountAmount,
    List<PaymentMethodOption>? paymentMethods,
    String? selectedPaymentMethod,
    String? selectedCountry,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
      tickets: tickets ?? this.tickets,
      selectedTicketName: selectedTicketName ?? this.selectedTicketName,
      quantity: quantity ?? this.quantity,
      promoCode: promoCode ?? this.promoCode,
      promoApplied: promoApplied ?? this.promoApplied,
      discountAmount: discountAmount ?? this.discountAmount,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}

class CheckoutViewModel extends StateNotifier<CheckoutState> {
  CheckoutViewModel() : super(const CheckoutState(isLoading: true)) {
    loadCheckoutData();
  }

  static const List<String> countryOptions = [
    'Pakistan',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Other',
  ];

  Future<void> loadCheckoutData() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));

    const tickets = [
      TicketOption(
        name: 'General Admission',
        description: 'Standard entry to the event',
        price: 50.0,
        availableSeats: 150,
      ),
      TicketOption(
        name: 'VIP Access',
        description: 'Exclusive access to VIP areas',
        price: 150.0,
        availableSeats: 50,
        availableUntil: 'Ends Oct 10',
      ),
      TicketOption(
        name: 'Premium Pass',
        description: 'All-inclusive premium experience',
        price: 250.0,
        availableSeats: 20,
      ),
    ];

    const paymentMethods = [
      PaymentMethodOption(name: 'Visa', subtitle: 'Credit Card'),
      PaymentMethodOption(name: 'JazzCash', subtitle: 'Mobile Wallet'),
      PaymentMethodOption(name: 'EasyPaisa', subtitle: 'Mobile Wallet'),
    ];

    state = state.copyWith(
      isLoading: false,
      tickets: tickets,
      selectedTicketName: tickets.first.name,
      paymentMethods: paymentMethods,
      selectedPaymentMethod: paymentMethods.first.name,
    );
  }

  void selectTicket(String name) {
    state = state.copyWith(selectedTicketName: name, clearError: true);
  }

  void increment() {
    state = state.copyWith(quantity: state.quantity + 1);
  }

  void decrement() {
    if (state.quantity > 1) {
      state = state.copyWith(quantity: state.quantity - 1);
    }
  }

  void selectPaymentMethod(String name) {
    state = state.copyWith(selectedPaymentMethod: name);
  }

  void selectCountry(String? country) {
    state = state.copyWith(selectedCountry: country);
  }

  void applyPromoCode(String code) {
    if (code.trim().toUpperCase() == 'SAVE10') {
      state = state.copyWith(promoApplied: true, discountAmount: 5.0, clearError: true);
    } else {
      state = state.copyWith(promoApplied: false, discountAmount: 0.0, errorMessage: 'Invalid promo code.');
    }
  }

  Future<void> completePurchase({
    required String fullName,
    required String billingAddress,
    required String city,
    required String postalCode,
  }) async {
    if (fullName.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Full Name is required.', clearSuccess: true);
      return;
    }

    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      state = state.copyWith(
        isSubmitting: false,
        successMessage: 'Purchase complete! Redirecting to confirmation...',
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Purchase failed. Please try again.',
        clearSuccess: true,
      );
    }
  }
}

final checkoutProvider = StateNotifierProvider.autoDispose<CheckoutViewModel, CheckoutState>((ref) {
  return CheckoutViewModel();
});
