import 'package:get/get.dart';
import 'package:frontend_delpick/data/repositories/tracking_repository.dart';
import 'package:frontend_delpick/data/providers/tracking_provider.dart';

class DriverBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<DriverRemoteDataSource>(
      () => DriverRemoteDataSource(Get.find()),
    );
    Get.lazyPut<OrderRemoteDataSource>(() => OrderRemoteDataSource(Get.find()));
    Get.lazyPut<TrackingRemoteDataSource>(
      () => TrackingRemoteDataSource(Get.find()),
    );

    // Providers
    Get.lazyPut<DriverProvider>(
      () => DriverProvider(remoteDataSource: Get.find()),
    );
    Get.lazyPut<OrderProvider>(
      () => OrderProvider(remoteDataSource: Get.find()),
    );
    Get.lazyPut<TrackingProvider>(
      () => TrackingProvider(remoteDataSource: Get.find()),
    );

    // Repositories
    Get.lazyPut<DriverRepository>(() => DriverRepository(Get.find()));
    Get.lazyPut<OrderRepository>(() => OrderRepository(Get.find()));
    Get.lazyPut<TrackingRepository>(() => TrackingRepository(Get.find()));

    // Controllers
    Get.lazyPut<DriverHomeController>(
      () => DriverHomeController(
        driverRepository: Get.find(),
        orderRepository: Get.find(),
        locationService: Get.find(),
      ),
    );
    Get.lazyPut<DriverRequestController>(
      () => DriverRequestController(
        driverRepository: Get.find(),
        orderRepository: Get.find(),
      ),
    );
    Get.lazyPut<DeliveryController>(
      () => DeliveryController(
        trackingRepository: Get.find(),
        orderRepository: Get.find(),
        locationService: Get.find(),
      ),
    );
    Get.lazyPut<DriverLocationController>(
      () => DriverLocationController(
        driverRepository: Get.find(),
        locationService: Get.find(),
      ),
    );
    Get.lazyPut<DriverOrdersController>(
      () => DriverOrdersController(Get.find()),
    );
    Get.lazyPut<DriverEarningsController>(
      () => DriverEarningsController(Get.find()),
    );
    Get.lazyPut<DriverProfileController>(
      () => DriverProfileController(Get.find()),
    );
  }
}
