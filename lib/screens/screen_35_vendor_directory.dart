import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/vendor_featured_card.dart';
import '../widgets/category_grid_item.dart';
import '../widgets/vendor_popular_list_item.dart';

class Screen35VendorDirectory extends StatelessWidget {
  const Screen35VendorDirectory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Search Bar and Filter
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.grey),
                            hintText: 'Search vendors services categories',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Filter Icon & Sort Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/s35icon1.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Text(
                          'Sort by: Popularity',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.darkText,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.darkText,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 2. Featured Vendors
                const Text('Featured Vendors', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      VendorFeaturedCard(
                        title: 'The Grand Ballroom',
                        subtitle: 'Wedding Venue',
                        imagepath: 'assets/images/s35imag1.jpg',
                        imageColor: Color(0xFF6B4226),
                      ),
                      VendorFeaturedCard(
                        title: 'Cuisine Masters',
                        subtitle: 'Catering',
                        imagepath: 'assets/images/s35image2.png',
                        imageColor: Color(0xFF3B5B43),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Explore Categories
                const Text('Explore Categories', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: const [
                    CategoryGridItem(
                      title: 'Venues',
                      icon: Icons.storefront,
                      backgroundColor: Color(0xFFF9EDE3),
                      imagepath: 'assets/images/s35image3.jpg',
                      iconColor: Color(0xFFC48671),
                    ),
                    CategoryGridItem(
                      title: 'Catering',
                      icon: Icons.restaurant_menu,
                      backgroundColor: Color(0xFF2E404F),
                      imagepath: 'assets/images/s35image4.jpg',
                      iconColor: Colors.white,

                    ),
                    CategoryGridItem(
                      title: 'Photography',
                      icon: Icons.camera_alt,
                      backgroundColor: Color(0xFF2E404F),
                      imagepath: 'assets/images/s35image5.jpg',
                      iconColor: Colors.white,
                    ),
                    CategoryGridItem(
                      title: 'Decoration',
                      icon: Icons.auto_awesome,
                      backgroundColor: Color(0xFFF8E7D3),
                      imagepath: 'assets/images/s35image6.jpg',
                      iconColor: Color(0xFFC48671),
                    ),
                    CategoryGridItem(
                      title: 'AV Equipment',
                      icon: Icons.speaker,
                      backgroundColor: Color(0xFFEFEFEF),
                      iconColor: Colors.grey,
                      imagepath: 'assets/images/s35image7.jpg',
                    ),
                    CategoryGridItem(
                      title: 'Entertainment',
                      icon: Icons.music_note,
                      backgroundColor: Color(0xFFEBEFF2),
                      iconColor: Colors.blueGrey,
                      imagepath: 'assets/images/s35image8.jpg',
                    ),
                    CategoryGridItem(
                      title: 'Security',
                      icon: Icons.security,
                      backgroundColor: Color(0xFFF3F7F6),
                      imagepath: 'assets/images/s35image9.jpg',
                      iconColor: Colors.blueGrey,
                    ),
                    CategoryGridItem(
                      title: 'Transportation',
                      icon: Icons.directions_car,
                      backgroundColor: Color(0xFFDEF1E5),
                      imagepath: 'assets/images/s35image10.jpg',
                      iconColor: Colors.teal,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 4. Popular Vendors
                const Text('Popular Vendors', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                const VendorPopularListItem(
                  title: 'Elite Events Co.',
                  subtitle: 'Event Planning',
                  badgeColor: Color(0xFFE7D1B9),
                  imagepath: 'assets/images/s35image11.jpg',
                ),
                const VendorPopularListItem(
                  title: 'Catering Delights',
                  subtitle: 'Catering',
                  badgeColor: Color(0xFFE1C6A5),
                  imagepath: 'assets/images/s35image12.jpg',
                ),
                const VendorPopularListItem(
                  title: 'PhotoGenius Studios',
                  subtitle: 'Photography',
                  badgeColor: Color(0xFFEEDDCC),
                  imagepath: 'assets/images/s35image13.jpg',
                ),
                const VendorPopularListItem(
                  title: 'Decor Dreams',
                  subtitle: 'Decoration',
                  badgeColor: Color(0xFFE1DAC3),
                  imagepath: 'assets/images/s35image14.jpg',
                ),
                const SizedBox(height: 24),

                // 5. Recently Viewed
                const Text('Recently Viewed', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      VendorFeaturedCard(
                        title: 'The Grand Ballroom',
                        subtitle: '',
                        imageColor: Color(0xFF6B4226),
                        imagepath: 'assets/images/s35image15.jpg',
                      ),
                      VendorFeaturedCard(
                        title: 'Cuisine Masters',
                        subtitle: '',
                        imageColor: Color(0xFF3B5B43),
                        imagepath: 'assets/images/s35image16.jpg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Space for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.filter_alt, color: Colors.white),
      ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              SvgPicture.asset(
                'assets/images/s32icon1home.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),
          SvgPicture.asset(
            'assets/images/s35icon1vendors.svg',
            colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
            width: 44,
            height: 44,
          ),
              SvgPicture.asset(
                'assets/images/s35icon2events.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),
              SvgPicture.asset(
                'assets/images/s35icon3message.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),
              SvgPicture.asset(
                'assets/images/s32icon4profile.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),
            ],
          ),
        ),
    );
  }
}
