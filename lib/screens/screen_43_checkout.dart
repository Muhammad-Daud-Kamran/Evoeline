import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/outlined_text_field.dart';
import '../viewmodels/checkout_viewmodel.dart';

/// Screen 43: Complete Your Purchase (Checkout) - MVVM Architecture
class Screen43Checkout extends ConsumerStatefulWidget {
  const Screen43Checkout({super.key});

  @override
  ConsumerState<Screen43Checkout> createState() => _Screen43CheckoutState();
}

class _Screen43CheckoutState extends ConsumerState<Screen43Checkout> {
  final _fullNameController = TextEditingController();
  final _billingAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _promoCodeController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _billingAddressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkoutProvider);
    final vm = ref.read(checkoutProvider.notifier);

    // Show success snackbar and navigate
    ref.listen<CheckoutState>(checkoutProvider, (prev, next) {
      if (next.successMessage != null && prev?.successMessage != next.successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.successMessage!), backgroundColor: AppColors.primaryGreen),
        );
        context.pop();
      }
    });

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryGreen)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Complete Your Purchase',
          style: TextStyle(color: AppColors.darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColors.iconColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Choose Your Ticket Type ──────────────────
            _buildSectionTitle('Choose Your Ticket Type'),
            const SizedBox(height: 12),
            ...state.tickets.map((ticket) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildTicketTypeCard(
                ticket: ticket,
                isSelected: state.selectedTicketName == ticket.name,
                onTap: () => vm.selectTicket(ticket.name),
              ),
            )),
            const SizedBox(height: 24),

            // ── Select Quantity ──────────────────────────
            _buildSectionTitle('Select Quantity'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Quantity', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkText)),
                Row(
                  children: [
                    _buildQuantityButton(Icons.remove, vm.decrement),
                    const SizedBox(width: 16),
                    Text('${state.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 16),
                    _buildQuantityButton(Icons.add, vm.increment),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Promo Code ───────────────────────────────
            _buildSectionTitle('Promo Code'),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: OutlinedTextField(
                    label: '',
                    hintText: 'Enter promo code',
                    controller: _promoCodeController,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => vm.applyPromoCode(_promoCodeController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightGreyBackground,
                      foregroundColor: AppColors.darkText,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            if (state.promoApplied) ...[
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.check, color: AppColors.successGreen, size: 16),
                  SizedBox(width: 4),
                  Text('Promo Applied!', style: TextStyle(color: AppColors.successGreen, fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
            const SizedBox(height: 24),

            // ── Price Summary ────────────────────────────
            _buildSectionTitle('Price Summary'),
            const SizedBox(height: 16),
            _buildPriceRow(state.ticketLabel, state.subtotalText),
            const SizedBox(height: 8),
            _buildPriceRow('Discount', state.discountText, isDiscount: true),
            const SizedBox(height: 8),
            _buildPriceRow('Service Fee', state.serviceFeeText),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(color: AppColors.dividerColor),
            ),
            _buildPriceRow('Total Amount', state.totalText, isTotal: true),
            const SizedBox(height: 8),
            const Text('All prices include applicable taxes', style: TextStyle(color: AppColors.lightText, fontSize: 11)),
            const SizedBox(height: 24),

            // ── Select Payment Method ────────────────────
            _buildSectionTitle('Select Payment Method'),
            const SizedBox(height: 12),
            ...state.paymentMethods.map((method) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildPaymentMethodCard(
                title: method.name,
                subtitle: method.subtitle,
                isSelected: state.selectedPaymentMethod == method.name,
                onTap: () => vm.selectPaymentMethod(method.name),
              ),
            )),
            const SizedBox(height: 24),

            // ── Billing Information ──────────────────────
            OutlinedTextField(label: 'Full Name', hintText: '', controller: _fullNameController),
            const SizedBox(height: 16),
            OutlinedTextField(label: 'Billing Address', hintText: '', controller: _billingAddressController),
            const SizedBox(height: 16),
            OutlinedTextField(label: 'City', hintText: '', controller: _cityController),
            const SizedBox(height: 16),
            OutlinedTextField(label: 'Postal Code', hintText: '', controller: _postalCodeController),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Country',
              value: state.selectedCountry,
              options: CheckoutViewModel.countryOptions,
              onChanged: vm.selectCountry,
            ),
            const SizedBox(height: 24),

            // Privacy text
            const Center(
              child: Text(
                'Your data is encrypted and never stored.\nBy completing your purchase, you agree to the Terms and Conditions and Refund Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.lightText, fontSize: 11, height: 1.5),
              ),
            ),
            const SizedBox(height: 12),

            // Error message
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 13)),
              ),

            const SizedBox(height: 12),

            // Complete Purchase Button
            state.isSubmitting
                ? const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen))
                : CustomButton(
                    text: 'Complete Purchase',
                    onPressed: () => vm.completePurchase(
                      fullName: _fullNameController.text,
                      billingAddress: _billingAddressController.text,
                      city: _cityController.text,
                      postalCode: _postalCodeController.text,
                    ),
                  ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkText),
    );
  }

  Widget _buildTicketTypeCard({
    required TicketOption ticket,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.analyticsLightGreen : AppColors.background,
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.dividerColor,
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ticket.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.darkText)),
                      Text('\$${ticket.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.darkText)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(ticket.description, style: const TextStyle(color: AppColors.lightText, fontSize: 12)),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    children: [
                      Text('${ticket.availableSeats} left', style: const TextStyle(color: AppColors.successGreen, fontSize: 12, fontWeight: FontWeight.w600)),
                      if (ticket.availableUntil != null) ...[
                        const Text('•', style: TextStyle(color: AppColors.lightText, fontSize: 12)),
                        Text(ticket.availableUntil!, style: const TextStyle(color: AppColors.lightText, fontSize: 12, fontStyle: FontStyle.italic)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isSelected ? AppColors.primaryGreen : AppColors.dividerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.dividerColor,
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.darkText)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: AppColors.lightText, fontSize: 12)),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primaryGreen : AppColors.dividerColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(color: AppColors.lightGreyBackground, shape: BoxShape.circle),
        child: Icon(icon, size: 16, color: AppColors.darkText),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(
          color: isTotal ? AppColors.darkText : AppColors.lightText,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          fontSize: isTotal ? 16 : 14,
        )),
        Text(amount, style: TextStyle(
          color: AppColors.darkText,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          fontSize: isTotal ? 16 : 14,
        )),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.darkText)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: const Text('Select', style: TextStyle(color: AppColors.lightText)),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.iconColor),
              items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
