// lib/features/customer/controllers/store_controller.dart

import 'package:get/get.dart';
import 'package:frontend_delpick/core/errors/failures.dart';
import 'package:frontend_delpick/core/errors/error_handler.dart';
import 'package:frontend_delpick/data/models/store/store_model.dart';
import 'package:frontend_delpick/data/repositories/store_repository.dart';
import 'package:frontend_delpick/core/services/external/location_service.dart';

class StoreController extends GetxController {
  final StoreRepository _storeRepository;
  final LocationService _locationService;

  StoreController({
    required StoreRepository storeRepository,
    required LocationService locationService,
  })  : _storeRepository = storeRepository,
        _locationService = locationService;

  // Observable state
  final RxBool _isLoading = false.obs;
  final RxList<StoreModel> _stores = <StoreModel>[].obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _hasError = false.obs;
  final RxBool _hasLocation = false.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  List<StoreModel> get stores => _stores;
  String get errorMessage => _errorMessage.value;
  bool get hasError => _hasError.value;
  bool get hasLocation => _hasLocation.value;
  bool get hasStores => _stores.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyStores();
  }

  Future<void> fetchNearbyStores() async {
    _isLoading.value = true;
    _hasError.value = false;
    _errorMessage.value = '';

    try {
      // Get current location
      final position = await _locationService.getCurrentLocation();

      if (position != null) {
        _hasLocation.value = true;

        // Fetch stores from repository
        final result = await _storeRepository.getNearbyStores(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        if (result.isSuccess && result.data != null) {
          _stores.value = result.data!;
        } else {
          _hasError.value = true;
          _errorMessage.value = result.message;
        }
      } else {
        _hasLocation.value = false;
        // Fallback to get all stores without location
        final result = await _storeRepository.getAllStores();

        if (result.isSuccess && result.data != null) {
          _stores.value = result.data!;
        } else {
          _hasError.value = true;
          _errorMessage.value = result.message;
        }
      }
    } catch (e) {
      _hasError.value = true;
      if (e is Exception) {
        final failure = ErrorHandler.handleException(e);
        _errorMessage.value = ErrorHandler.getErrorMessage(failure);
      } else {
        _errorMessage.value = 'An unexpected error occurred';
      }
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshStores() async {
    await fetchNearbyStores();
  }

  void sortStoresByDistance() {
    _stores.sort((a, b) {
      final distanceA = a.distance ?? double.infinity;
      final distanceB = b.distance ?? double.infinity;
      return distanceA.compareTo(distanceB);
    });
  }

  void sortStoresByRating() {
    _stores.sort((a, b) {
      final ratingA = a.rating ?? 0.0;
      final ratingB = b.rating ?? 0.0;
      return ratingB.compareTo(ratingA); // Descending order
    });
  }

  void filterStores(String query) {
    if (query.isEmpty) {
      refreshStores();
      return;
    }

    // Filter stores by name or category
    final filteredStores = _stores.where((store) {
      final name = store.name.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    _stores.value = filteredStores;
  }
}

// lib/features/customer/screens/store_list_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_delpick/app/routes/app_routes.dart';
import 'package:frontend_delpick/core/widgets/loading_widget.dart';
import 'package:frontend_delpick/core/widgets/empty_state_widget.dart';
import 'package:frontend_delpick/core/widgets/error_widget.dart' as app_error;
import 'package:frontend_delpick/features/customer/controllers/store_controller.dart';
import 'package:frontend_delpick/features/customer/widgets/store_card.dart';
import 'package:frontend_delpick/features/customer/widgets/store_filter_widget.dart';
import 'package:frontend_delpick/features/customer/widgets/store_search_bar.dart';
import 'package:frontend_delpick/app/themes/app_colors.dart';

class StoreListScreen extends StatelessWidget {
  final StoreController controller = Get.find<StoreController>();

  StoreListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshStores,
        child: Obx(() {
          if (controller.isLoading) {
            return const LoadingWidget();
          }

          if (controller.hasError) {
            return app_error.ErrorWidget(
              message: controller.errorMessage,
              onRetry: controller.refreshStores,
            );
          }

          if (!controller.hasStores) {
            return const EmptyStateWidget(
              message: 'No restaurants found nearby',
              icon: Icons.store_mall_directory_outlined,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.stores.length,
            itemBuilder: (context, index) {
              final store = controller.stores[index];
              return StoreCard(
                store: store,
                onTap: () => Get.toNamed(
                  Routes.STORE_DETAIL,
                  arguments: {'storeId': store.id},
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: StoreSearchBar(
          onSearch: controller.filterStores,
          onClear: controller.refreshStores,
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StoreFilterWidget(
        onSortByDistance: controller.sortStoresByDistance,
        onSortByRating: controller.sortStoresByRating,
      ),
    );
  }
}

// lib/features/customer/widgets/store_card.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend_delpick/data/models/store/store_model.dart';
import 'package:frontend_delpick/app/themes/app_colors.dart';
import 'package:frontend_delpick/app/themes/app_text_styles.dart';
import 'package:frontend_delpick/core/constants/app_constants.dart';

class StoreCard extends StatelessWidget {
  final StoreModel store;
  final VoidCallback onTap;

  const StoreCard({
    Key? key,
    required this.store,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: store.imageUrl != null
                    ? CachedNetworkImage(
                  imageUrl: store.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppConstants.defaultStoreImageUrl,
                    fit: BoxFit.cover,
                  ),
                )
                    : Image.asset(
                  AppConstants.defaultStoreImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Store info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Store name and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          store.name,
                          style: AppTextStyles.h6,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildStatusBadge(),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Store address
                  Text(
                    store.address,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Rating and distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rating
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.rating,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            store.displayRating,
                            style: AppTextStyles.bodyMedium,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${store.reviewCount ?? 0})',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),

                      // Distance
                      if (store.distance != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              store.displayDistance,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final isOpen = store.isOpen();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isOpen ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isOpen ? 'Open' : 'Closed',
        style: AppTextStyles.labelSmall.copyWith(
          color: isOpen ? AppColors.success : AppColors.error,
        ),
      ),
    );
  }
}