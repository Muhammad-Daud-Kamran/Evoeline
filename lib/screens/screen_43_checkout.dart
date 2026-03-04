import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/outlined_text_field.dart';

/// Screen 43: Complete Your Purchase (Checkout)
class Screen43Checkout extends StatefulWidget {
  const Screen43Checkout({super.key});

  @override
  State<Screen43Checkout> createState() => _Screen43CheckoutState();
}

class _Screen43CheckoutState extends State<Screen43Checkout> {
  String _selectedTicketType = 'General Admission';
  int _quantity = 1;
  String _selectedPaymentMethod = 'Visa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Complete Your Purchase',
          style: TextStyle(
            color: AppColors.darkText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => Navigator.pop(context),
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
            // Choose Your Ticket Type
            _buildSectionTitle('Choose Your Ticket Type'),
            const SizedBox(height: 12),
            _buildTicketTypeCard(
              'General Admission',
              'Standard entry to the event',
            ),
            const SizedBox(height: 8),
            _buildTicketTypeCard('VIP Access', 'Exclusive access to VIP areas'),
            const SizedBox(height: 8),
            _buildTicketTypeCard(
              'Premium Pass',
              'All-inclusive premium experience',
            ),
            const SizedBox(height: 24),

            // Select Quantity
            _buildSectionTitle('Select Quantity'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Quantity',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                Row(
                  children: [
                    _buildQuantityButton(Icons.remove, () {
                      if (_quantity > 1) setState(() => _quantity--);
                    }),
                    const SizedBox(width: 16),
                    Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildQuantityButton(Icons.add, () {
                      setState(() => _quantity++);
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Available: 100 tickets',
              style: TextStyle(
                color: AppColors.successGreen,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Promo Code
            _buildSectionTitle('Promo Code'),
            const SizedBox(height: 6),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: OutlinedTextField(
                    label: '',
                    hintText: 'Enter promo code',
                  ),
                ),
                const SizedBox(width: 12),


                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightGreyBackground,
                      foregroundColor: AppColors.darkText,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.check, color: AppColors.successGreen, size: 16),
                SizedBox(width: 4),
                Text(
                  'Promo Applied!',
                  style: TextStyle(
                    color: AppColors.successGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Price Summary
            _buildSectionTitle('Price Summary'),
            const SizedBox(height: 16),
            _buildPriceRow('Ticket Price x $_quantity', '\$50.00'),
            const SizedBox(height: 8),
            _buildPriceRow('Discount', '-\$5.00', isDiscount: true),
            const SizedBox(height: 8),
            _buildPriceRow('Service Fee', '\$2.50'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(color: AppColors.dividerColor),
            ),
            _buildPriceRow('Total Amount', '\$47.50', isTotal: true),
            const SizedBox(height: 8),
            const Text(
              'All prices include applicable taxes',
              style: TextStyle(color: AppColors.lightText, fontSize: 11),
            ),
            const SizedBox(height: 24),

            // Select Payment Method
            _buildSectionTitle('Select Payment Method'),
            const SizedBox(height: 12),
            _buildPaymentMethodCard('Visa', 'Credit Card'),
            const SizedBox(height: 8),
            _buildPaymentMethodCard('JazzCash', 'Mobile Wallet'),
            const SizedBox(height: 8),
            _buildPaymentMethodCard('EasyPaisa', 'Mobile Wallet'),
            const SizedBox(height: 24),

            // Billing Information
            const OutlinedTextField(label: 'Full Name', hintText: ''),
            const SizedBox(height: 16),
            const OutlinedTextField(label: 'Billing Address', hintText: ''),
            const SizedBox(height: 16),
            const OutlinedTextField(label: 'City', hintText: ''),
            const SizedBox(height: 16),
            const OutlinedTextField(label: 'Postal Code', hintText: ''),
            const SizedBox(height: 16),
            _buildDropdownField('Country'),
            const SizedBox(height: 24),

            // Privacy text
            const Center(
              child: Text(
                'Your data is encrypted and never stored.\nBy completing your purchase, you agree to the Terms and Conditions and Refund Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.lightText,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Complete Purchase Button
            CustomButton(text: 'Complete Purchase', onPressed: () {}),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
    );
  }

  Widget _buildTicketTypeCard(String title, String subtitle) {
    final bool isSelected = _selectedTicketType == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedTicketType = title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.analyticsLightGreen
              : AppColors.background,
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
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isSelected
                          ? AppColors.darkText
                          : AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.lightText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppColors.primaryGreen
                  : AppColors.dividerColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(String title, String subtitle) {
    final bool isSelected = _selectedPaymentMethod == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = title),
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
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.lightText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppColors.primaryGreen
                  : AppColors.dividerColor,
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
        decoration: const BoxDecoration(
          color: AppColors.lightGreyBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: AppColors.darkText),
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? AppColors.darkText : AppColors.lightText,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: isTotal
                ? AppColors.darkText
                : (isDiscount ? AppColors.darkText : AppColors.darkText),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
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
              hint: const Text(
                'Select',
                style: TextStyle(color: AppColors.lightText),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.iconColor,
              ),
              items: const [],
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
