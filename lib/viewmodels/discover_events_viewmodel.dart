// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart'; // Required for Riverpod 2.x StateNotifier
import '../models/event_model.dart';
import '../models/registration_models/pricing_tier_model.dart';

class DiscoverEventsState {
  final bool isLoading;
  final String errorMessage;
  final String searchQuery;
  final String selectedCategory; // "All", "Technology", "Business", etc.

  final List<EventModel> eventsNearYou;
  final List<EventModel> trendingEvents;
  final List<EventModel> upcomingEvents;
  final List<EventModel> recommendedEvents;
  final List<EventModel> pastEvents;

  const DiscoverEventsState({
    this.isLoading = false,
    this.errorMessage = '',
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.eventsNearYou = const [],
    this.trendingEvents = const [],
    this.upcomingEvents = const [],
    this.recommendedEvents = const [],
    this.pastEvents = const [],
  });

  DiscoverEventsState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    String? selectedCategory,
    List<EventModel>? eventsNearYou,
    List<EventModel>? trendingEvents,
    List<EventModel>? upcomingEvents,
    List<EventModel>? recommendedEvents,
    List<EventModel>? pastEvents,
  }) {
    return DiscoverEventsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      eventsNearYou: eventsNearYou ?? this.eventsNearYou,
      trendingEvents: trendingEvents ?? this.trendingEvents,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      recommendedEvents: recommendedEvents ?? this.recommendedEvents,
      pastEvents: pastEvents ?? this.pastEvents,
    );
  }
}

class DiscoverEventsViewModel extends StateNotifier<DiscoverEventsState> {
  DiscoverEventsViewModel() : super(const DiscoverEventsState(isLoading: true)) {
    loadDiscoverData();
  }

  // All initial unfiltered data
  List<EventModel> _allUpcomingEvents = [];
  List<EventModel> _allRecommendedEvents = [];

  Future<void> loadDiscoverData() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final eventsNearYou = [
        EventModel.empty().copyWith(
          title: 'Tech Meetup',
          category: 'Technology',
          description: 'A premier gathering for tech enthusiasts and innovators.',
          startDate: 'Oct 26, 2024',
          isFree: true,
          bannerImage: 'assets/images/s40image1.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Business Network',
          category: 'Business',
          description: 'Connect with local and regional business leaders.',
          startDate: 'Nov 15, 2024',
          isFree: false,
          tiers: [PricingTierModel(id: 'T1', name: 'Standard', price: 20, availableUntil: '', seats: 100)],
          bannerImage: 'assets/images/s40image2.png',
        ),
      ];

      final trendingEvents = [
        EventModel.empty().copyWith(
          title: 'Future of Tech',
          category: 'Technology',
          description: 'Explore the frontier of emerging technologies.',
          isFree: false,
          tiers: [PricingTierModel(id: 'T1', name: 'Standard', price: 150, availableUntil: '', seats: 100)],
          bannerImage: 'assets/images/s40image3.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Global Business',
          category: 'Business',
          description: 'Strategies for succeeding in a globalized economy.',
          isFree: true,
          bannerImage: 'assets/images/s40image4.png',
        ),
      ];

      _allUpcomingEvents = [
        EventModel.empty().copyWith(
          title: 'AI in Business', category: 'Technology',
          description: 'AI implications in business.', startDate: 'Oct 28', isFree: true,
          bannerImage: 'assets/images/s40image5.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Startup Pitch Night', category: 'Business',
          description: 'Watch startups pitch.', startDate: 'Nov 2', isFree: false,
          tiers: [PricingTierModel(id: 'T1', name: 'Standard', price: 10, availableUntil: '', seats: 100)],
          bannerImage: 'assets/images/s40image6.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Healthcare Innovation', category: 'Health',
          description: 'New medtech.', startDate: 'Nov 10', isFree: true,
          bannerImage: 'assets/images/s40image7.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Digital Marketing Workshop', category: 'Marketing',
          description: 'SEO and SEM.', startDate: 'Nov 18', isFree: false,
          tiers: [PricingTierModel(id: 'T1', name: 'Standard', price: 25, availableUntil: '', seats: 100)],
          bannerImage: 'assets/images/s40image8.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'FinTech Conference', category: 'Finance',
          description: 'Future of money.', startDate: 'Nov 25', isFree: false,
          tiers: [PricingTierModel(id: 'T1', name: 'Standard', price: 100, availableUntil: '', seats: 100)],
          bannerImage: 'assets/images/s40image9.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Design Thinking Seminar', category: 'Design',
          description: 'UX patterns.', startDate: 'Dec 2', isFree: true,
          bannerImage: 'assets/images/s40image10.jpg',
        ),
      ];

      _allRecommendedEvents = [
        EventModel.empty().copyWith(
          title: 'AI Workshop', category: 'Technology',
          description: 'Hands-on AI model building.', startDate: 'Oct 29, 2024', isFree: false,
          tiers: [PricingTierModel(id: 'T1', name: 'Standard', price: 50, availableUntil: '', seats: 100)],
          bannerImage: 'assets/images/s40image11.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Marketing Seminar', category: 'Marketing',
          description: 'Growth hacking strategies.', startDate: 'Nov 5, 2024', isFree: true,
          bannerImage: 'assets/images/s40image12.jpg',
        ),
      ];

      final pastEvents = [
        EventModel.empty().copyWith(
          title: 'Past Event 1', category: 'Networking',
          description: 'Speed networking session.', startDate: 'Oct 1, 2024', isFree: true,
          bannerImage: 'assets/images/s40image14.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Past Event 2', category: 'Workshop',
          description: 'Building scalable apps.', startDate: 'Oct 8, 2024', isFree: false,
          tiers: [PricingTierModel(id: 'T1', name: 'Standard', price: 15, availableUntil: '', seats: 100)],
          bannerImage: 'assets/images/s40image15.jpg',
        ),
      ];

      state = state.copyWith(
        isLoading: false,
        eventsNearYou: eventsNearYou,
        trendingEvents: trendingEvents,
        upcomingEvents: _allUpcomingEvents,
        recommendedEvents: _allRecommendedEvents,
        pastEvents: pastEvents,
      );

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load discover events. Please try again.',
      );
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void setSelectedCategory(String category) {
    final newCategory = state.selectedCategory == category ? 'All' : category;
    state = state.copyWith(selectedCategory: newCategory);
    _applyFilters();
  }

  void _applyFilters() {
    final query = state.searchQuery.toLowerCase();
    final category = state.selectedCategory;

    // Filter Upcoming Events based on search and category
    List<EventModel> filteredUpcoming = _allUpcomingEvents.where((event) {
      final matchesSearch = query.isEmpty ||
          event.title.toLowerCase().contains(query) ||
          event.description.toLowerCase().contains(query);
      final matchesCategory = category == 'All' || event.category.toLowerCase() == category.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();

    // Reapply to state
    state = state.copyWith(
      upcomingEvents: filteredUpcoming,
    );
  }
}

final discoverEventsProvider = StateNotifierProvider<DiscoverEventsViewModel, DiscoverEventsState>((ref) {
  return DiscoverEventsViewModel();
});
