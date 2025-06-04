import 'package:get/get.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<StoreRemoteDataSource>(() => StoreRemoteDataSource(Get.find()));
    Get.lazyPut<MenuRemoteDataSource>(() => MenuRemoteDataSource(Get.find()));
    Get.lazyPut<OrderRemoteDataSource>(() => OrderRemoteDataSource(Get.find()));

    // Providers
    Get.lazyPut<StoreProvider>(
      () => StoreProvider(remoteDataSource: Get.find()),
    );
    Get.lazyPut<MenuProvider>(() => MenuProvider(remoteDataSource: Get.find()));
    Get.lazyPut<OrderProvider>(
      () => OrderProvider(remoteDataSource: Get.find()),
    );

    // Repositories
    Get.lazyPut<StoreRepository>(() => StoreRepository(Get.find()));
    Get.lazyPut<MenuRepository>(() => MenuRepository(Get.find()));
    Get.lazyPut<OrderRepository>(() => OrderRepository(Get.find()));

    // Controllers
    Get.lazyPut<StoreDashboardController>(
      () => StoreDashboardController(
        storeRepository: Get.find(),
        orderRepository: Get.find(),
        menuRepository: Get.find(),
      ),
    );
    Get.lazyPut<MenuManagementController>(
      () => MenuManagementController(Get.find()),
    );
    Get.lazyPut<AddMenuItemController>(() => AddMenuItemController(Get.find()));
    Get.lazyPut<StoreOrdersController>(() => StoreOrdersController(Get.find()));
    Get.lazyPut<StoreAnalyticsController>(
      () => StoreAnalyticsController(
        storeRepository: Get.find(),
        orderRepository: Get.find(),
      ),
    );
    Get.lazyPut<StoreSettingsController>(
      () => StoreSettingsController(Get.find()),
    );
    Get.lazyPut<StoreProfileController>(
      () => StoreProfileController(Get.find()),
    );
  }
}
