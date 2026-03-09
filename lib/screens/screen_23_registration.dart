import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/registration_card.dart';
import '../widgets/step_progress_indicator.dart';
import '../widgets/accordion_section.dart';

class Screen23Registration extends StatefulWidget {
  const Screen23Registration({Key? key}) : super(key: key);

  @override
  State<Screen23Registration> createState() => _Screen23RegistrationState();
}

class _Screen23RegistrationState extends State<Screen23Registration> {
  // Schema: pricing.isFree & pricing.currency
  bool _isFree = false;
  String _currency = "PKR";

  // State for Pricing Tiers
  final List<Map<String, dynamic>> _tiers = [
    {'name': 'Early Bird', 'price': '1500', 'until': '2024-03-15', 'seats': '30'},
  ];

  // State for Discounts
  bool _studentDiscountEnabled = true;
  bool _groupDiscountEnabled = true;

  // State for Custom Registration Fields (Schema: label, type, options, required)
  final List<Map<String, dynamic>> _customFields = [
    {'label': 'University ID', 'type': 'Text', 'required': true, 'options': []},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create Event', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 4 of 5 - Registration', style: AppTextStyles.bodyText),
            const SizedBox(height: 8),
            const StepProgressIndicator(currentStep: 4, totalSteps: 5),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable Registration', style: AppTextStyles.bodyText),
                Switch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: AppColors.primaryGreen,
                ),
              ],
            ),
            const SizedBox(height: 24),

            const RegistrationCard(
              title: 'Registration Schedule',
              description: 'Set the dates when registration opens and closes.',
              buttonText: 'Set Dates',
              iconData: Icons.calendar_today_outlined,
              imagePath: 'assets/images/registrationpage_image1.jpg',
            ),
            const SizedBox(height: 24),

            // Added: Capacity & Payment Card (matches Registration Schedule style)
            const RegistrationCard(
              title: 'Capacity & Payment',
              description: 'Manage event capacity, waitlist, and ticket pricing.',
              buttonText: 'Configure',
              iconData: Icons.confirmation_num_outlined,
              imagePath: 'assets/images/registrationpage_image2.jpg',
            ),
            const SizedBox(height: 24),

            // Pricing Tiers Section (Handles the "Pricing" part of the schema)
            AccordionSection(
              title: 'Pricing & Tiers',
              isExpanded: true,
              child: Column(
                children: [
                  // Added: isFree and Currency selection from schema
                  Row(
                    children: [
                      const Text('Free Event', style: AppTextStyles.bodyText),
                      Switch(
                        value: _isFree,
                        onChanged: (val) => setState(() => _isFree = val),
                        activeColor: AppColors.primaryGreen,
                      ),
                      const Spacer(),
                      if (!_isFree) ...[
                        const Text('Currency: ', style: AppTextStyles.label),
                        Text(_currency, style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold)),
                      ]
                    ],
                  ),
                  const Divider(),
                  if (!_isFree) ...[
                    ..._tiers.map((tier) => _buildTierItem(tier)).toList(),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: '+ Add Pricing Tier',
                      backgroundColor: AppColors.lightGreyBackground,
                      textColor: AppColors.darkText,
                      onPressed: () => _showAddTierDialog(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Discounts Section (Schema: studentDiscount, groupDiscount)
            AccordionSection(
              title: 'Discounts',
              child: Column(
                children: [
                  _buildDiscountToggle(
                    'Student Discount',
                    _studentDiscountEnabled,
                        (val) => setState(() => _studentDiscountEnabled = val),
                  ),
                  if (_studentDiscountEnabled) ...[
                    _buildDiscountField('Percentage (%)', '20'),
                    _buildCheckbox('Requires Verification', true),
                  ],
                  const Divider(height: 32),
                  _buildDiscountToggle(
                    'Group Discount',
                    _groupDiscountEnabled,
                        (val) => setState(() => _groupDiscountEnabled = val),
                  ),
                  if (_groupDiscountEnabled) ...[
                    _buildDiscountField('Min Group Size', '5'),
                    _buildDiscountField('Percentage (%)', '15'),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Custom Registration Fields Section
            AccordionSection(
              title: 'Custom Registration Fields',
              child: Column(
                children: [
                  ..._customFields.map((field) => _buildFieldItem(field)).toList(),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: '+ Add Custom Field',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor: AppColors.darkText,
                    onPressed: () => _showAddFieldDialog(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // UI Helpers
  Widget _buildTierItem(Map<String, dynamic> tier) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tier['name'], style: AppTextStyles.heading3),
              Text('Seats: ${tier['seats']} | Until: ${tier['until']}', style: AppTextStyles.label),
            ],
          ),
          Text('$_currency ${tier['price']}', style: AppTextStyles.heading3.copyWith(color: AppColors.primaryGreen)),
        ],
      ),
    );
  }

  Widget _buildFieldItem(Map<String, dynamic> field) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(field['label'], style: AppTextStyles.bodyText),
      subtitle: Text('Type: ${field['type']} | ${field['required'] ? 'Required' : 'Optional'}', style: AppTextStyles.label),
      trailing: IconButton(icon: const Icon(Icons.delete_outline, size: 20), onPressed: () {}),
    );
  }

  Widget _buildDiscountToggle(String title, bool val, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.bodyText),
        Switch(value: val, onChanged: onChanged, activeColor: AppColors.primaryGreen),
      ],
    );
  }

  Widget _buildDiscountField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: AppTextStyles.label,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label, bool val) {
    return Row(
      children: [
        Checkbox(value: val, onChanged: (v) {}, activeColor: AppColors.primaryGreen),
        Text(label, style: AppTextStyles.label),
      ],
    );
  }

  // Modal Dialogs for adding items
  void _showAddTierDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Pricing Tier', style: AppTextStyles.heading3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Tier Name (e.g. Regular)')),
            TextField(decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(decoration: const InputDecoration(labelText: 'Seats Limit'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Add')),
        ],
      ),
    );
  }

  void _showAddFieldDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Field', style: AppTextStyles.heading3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Field Label')),
            DropdownButtonFormField<String>(
              value: 'Text',
              items: ['Text', 'Dropdown', 'Checkbox'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (_) {},
              decoration: const InputDecoration(labelText: 'Field Type'),
            ),
            _buildCheckbox('Mark as Required', false),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Add')),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(text: 'Back', backgroundColor: AppColors.lightGreyBackground, textColor: AppColors.darkText, width: 100, onPressed: () {}),
            CustomButton(text: 'Next', backgroundColor: AppColors.primaryGreen, width: 100, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
