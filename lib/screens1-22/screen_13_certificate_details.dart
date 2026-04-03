import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';

class Screen13CertificateDetails extends StatelessWidget {
  const Screen13CertificateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Certificate Details', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Certificate Graphic
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F8E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Certificate Image Placeholder')),
            ),
            const SizedBox(height: 16),

            // Certificate Info
            const Text(
              'Certificate of Completion',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 4),
            const Text(
              'EventFlow',
              style: TextStyle(color: AppColors.primaryGreen, fontSize: 14),
            ),
            const Text(
              'Issued on January 15, 2024',
              style: TextStyle(color: AppColors.primaryGreen, fontSize: 14),
            ),

            // Download Icon Button
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.download, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),

            // Event Details
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event Details',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 12,
                        ),
                      ),
                      const Text(
                        'Blockchain Summit 2024',
                        style: AppTextStyles.heading3,
                      ),
                      const Text(
                        'Organized by Tech Innovators Inc.',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.analyticsLightGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'January 10-12, 2024',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEBE9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Blockchain Verification
            const Text(
              'Blockchain Verification',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '0xabc123...789\ndef',
                      style: TextStyle(fontSize: 14, color: AppColors.darkText),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Token ID',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '123456',
                      style: TextStyle(fontSize: 14, color: AppColors.darkText),
                    ),
                  ],
                ),
                SizedBox(width: 40), // Spacing placeholder
              ],
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Verify on Blockchain',
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Blockchain verification pending'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening PolygonScan explorer'),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.analyticsLightGreen,
                      foregroundColor: AppColors.darkText,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View on PolygonScan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Actions
            Center(
              child: Column(
                children: [
                  _buildActionIcon(Icons.download, 'Download PDF'),
                  const SizedBox(height: 16),
                  _buildActionIcon(Icons.ios_share, 'Share on LinkedIn'),
                  const SizedBox(height: 16),
                  _buildActionIcon(Icons.ios_share, 'Share'),
                  const SizedBox(height: 16),
                  _buildActionIcon(Icons.qr_code, 'QR Code'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Skills Acquired
            const Text('Skills Acquired', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSkillChip('Blockchain'),
                _buildSkillChip('Web3'),
                _buildSkillChip('Smart\nContracts'),
                _buildSkillChip('Decentralized\nFinance'),
                _buildSkillChip('Cryptography'),
              ],
            ),
            const SizedBox(height: 32),

            // Download Button Bottom
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Download Certificate (PDF)',
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Downloading Certificate (PDF)'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Certificates selected
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.lightText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        elevation: 10,
        backgroundColor: Colors.white,
        onTap: (_) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium_outlined),
            label: 'Certificates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.analyticsLightGreen,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.darkText, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.analyticsLightGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
      ),
    );
  }
}
