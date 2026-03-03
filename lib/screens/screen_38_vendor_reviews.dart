import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/review_list_item.dart';

class Screen38VendorReviews extends StatelessWidget {
  const Screen38VendorReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Vendor Reviews', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.darkText),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Rating Summary Banner
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side (Big Number)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                      const SizedBox(height: 4),
                      const Text('230 reviews', style: AppTextStyles.label),
                    ],
                  ),
                  const SizedBox(width: 24),

                  // Right side (Progress Bars)
                  Expanded(
                    child: Column(
                      children: [
                        _buildProgressBar(5, 0.70, '70%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(4, 0.20, '20%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(3, 0.05, '5%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(2, 0.03, '3%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(1, 0.02, '2%'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Sort By Dropdown Simulator
              const Text('Sort by', style: AppTextStyles.label),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.dividerColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Most popular', style: AppTextStyles.bodyText),
                    const Icon(Icons.arrow_drop_up, color: AppColors.darkText),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 3. Review List
              const ReviewListItem(
                authorName: 'Sophia Bennett',
                reviewText:
                    'The vendor was professional and delivered the setup perfectly on time. Highly recommend! ...Read more',
                ratingTimestampInfo: '5 stars • Corporate Gala',
                avatarColor: Color(0xFFDCC8B3),
                avatarInitials: 'SB',
              ),
              const ReviewListItem(
                authorName: 'Ethan Carter',
                reviewText:
                    'Good service, but there were some minor delays. Overall, satisfied. ...Read more',
                ratingTimestampInfo: '4 stars • University Workshop',
                avatarColor: Color(0xFFC4D5D9),
                avatarInitials: 'EC',
              ),
              const ReviewListItem(
                authorName: 'Olivia Davis',
                reviewText:
                    'Absolutely fantastic! The team went above and beyond to make our day special. ...Read more',
                ratingTimestampInfo: '5 stars • Wedding Reception',
                avatarColor: Color(0xFFD9A683),
                avatarInitials: 'OD',
              ),
              const ReviewListItem(
                authorName: 'Liam Foster',
                reviewText:
                    'Decent, but communication could have been better. Some issues with the setup. ...Read more',
                ratingTimestampInfo: '3 stars • Birthday Party',
                avatarColor: Color(0xFF1E3636),
                avatarInitials: 'LF',
              ),
              const ReviewListItem(
                authorName: 'Ava Green',
                reviewText:
                    'Exceptional service! The vendor was punctual, organized, and the quality was top-notch. ...Read more',
                ratingTimestampInfo: '5 stars • Conference',
                avatarColor: Color(0xFFDCC8B3),
                avatarInitials: 'AG',
              ),
              const SizedBox(height: 16),

              // 4. Banner Image (Two spheres on beige background)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCC8B3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFB5A18C),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 40,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFB5A18C),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. Load More Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.lightGreyBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Load More Reviews',
                    style: AppTextStyles.bodyText.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  Widget _buildProgressBar(
    int stars,
    double percentageFilled,
    String percentageText,
  ) {
    return Row(
      children: [
        Text(
          '$stars',
          style: AppTextStyles.label.copyWith(
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentageFilled,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade200,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 32,
          child: Text(
            percentageText,
            style: AppTextStyles.label.copyWith(fontSize: 10),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomBottomNav() {
    return BottomNavigationBar(
      currentIndex: 3, // "Reviews" selected
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.darkText,
      unselectedItemColor: AppColors.lightText,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      elevation: 8,
      backgroundColor: AppColors.background,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_outlined),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups_outlined),
          label: 'Vendors',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Reviews'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
