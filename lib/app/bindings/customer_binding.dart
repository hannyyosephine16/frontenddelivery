// import 'package:get/get.dart';
// import 'package:frontend_delpick/data/repositories/store_repository.dart';
// import 'package:frontend_delpick/data/repositories/menu_repository.dart';
// import 'package:frontend_delpick/data/repositories/order_repository.dart';
// import 'package:frontend_delpick/data/repositories/customer_repository.dart';
// import 'package:frontend_delpick/data/repositories/review_repository.dart';
// import 'package:frontend_delpick/data/repositories/tracking_repository.dart';
// import 'package:frontend_delpick/data/providers/store_provider.dart';
// import 'package:frontend_delpick/data/providers/menu_provider.dart';
// import 'package:frontend_delpick/data/providers/order_provider.dart';
// import 'package:frontend_delpick/data/providers/customer_provider.dart';
// import 'package:frontend_delpick/data/providers/review_provider.dart';
// import 'package:frontend_delpick/data/providers/tracking_provider.dart';
// import 'package:frontend_delpick/data/datasources/remote/store_remote_datasource.dart';
// import 'package:frontend_delpick/data/datasources/remote/menu_remote_datasource.dart';
// import 'package:frontend_delpick/data/datasources/remote/order_remote_datasource.dart';
// import 'package:frontend_delpick/data/datasources/remote/customer_remote_datasource.dart';
// import 'package:frontend_delpick/data/datasources/remote/review_remote_datasource.dart';
// import 'package:frontend_delpick/data/datasources/remote/tracking_remote_datasource.dart';
// import 'package:frontend_delpick/data/datasources/local/cart_local_datasource.dart';
// import 'package:frontend_delpick/features/customer/controllers/home_controller.dart';
// import 'package:frontend_delpick/features/customer/controllers/store_controller.dart';
// import 'package:frontend_delpick/features/customer/controllers/menu_controller.dart';
// import 'package:frontend_delpick/features/customer/controllers/cart_controller.dart';
// import 'package:frontend_delpick/features/customer/controllers/order_controller.dart';
// import 'package:frontend_delpick/features/customer/controllers/order_history_controller.dart';
// import 'package:frontend_delpick/features/customer/controllers/order_tracking_controller.dart';
// import 'package:frontend_delpick/features/customer/controllers/customer_profile_controller.dart';
//
// class CustomerBinding extends Bindings {
//   @override
//   void dependencies() {
//     // Data sources
//     Get.lazyPut<StoreRemoteDataSource>(() => StoreRemoteDataSource(Get.find()));
//     Get.lazyPut<MenuRemoteDataSource>(() => MenuRemoteDataSource(Get.find()));
//     Get.lazyPut<OrderRemoteDataSource>(() => OrderRemoteDataSource(Get.find()));
//     Get.lazyPut<CustomerRemoteDataSource>(
//       () => CustomerRemoteDataSource(Get.find()),
//     );
//     Get.lazyPut<ReviewRemoteDataSource>(
//       () => ReviewRemoteDataSource(Get.find()),
//     );
//     Get.lazyPut<TrackingRemoteDataSource>(
//       () => TrackingRemoteDataSource(Get.find()),
//     );
//     Get.lazyPut<CartLocalDataSource>(() => CartLocalDataSource(Get.find()));
//
//     // Providers
//     Get.lazyPut<StoreProvider>(
//       () => StoreProvider(remoteDataSource: Get.find()),
//     );
//     Get.lazyPut<MenuProvider>(() => MenuProvider(remoteDataSource: Get.find()));
//     Get.lazyPut<OrderProvider>(
//       () => OrderProvider(remoteDataSource: Get.find()),
//     );
//     Get.lazyPut<CustomerProvider>(
//       () => CustomerProvider(remoteDataSource: Get.find()),
//     );
//     Get.lazyPut<ReviewProvider>(
//       () => ReviewProvider(remoteDataSource: Get.find()),
//     );
//     Get.lazyPut<TrackingProvider>(
//       () => TrackingProvider(remoteDataSource: Get.find()),
//     );
//
//     // Repositories
//     Get.lazyPut<StoreRepository>(() => StoreRepository(Get.find()));
//     Get.lazyPut<MenuRepository>(() => MenuRepository(Get.find()));
//     Get.lazyPut<OrderRepository>(() => OrderRepository(Get.find()));
//     Get.lazyPut<CustomerRepository>(() => CustomerRepository(Get.find()));
//     Get.lazyPut<ReviewRepository>(() => ReviewRepository(Get.find()));
//     Get.lazyPut<TrackingRepository>(() => TrackingRepository(Get.find()));
//
//     // Controllers
//     Get.lazyPut<CustomerHomeController>(
//       () => CustomerHomeController(
//         storeRepository: Get.find(),
//         orderRepository: Get.find(),
//       ),
//     );
//     Get.lazyPut<StoreController>(() => StoreController(Get.find()));
//     Get.lazyPut<MenuController>(() => MenuController(Get.find()));
//     Get.lazyPut<CartController>(() => CartController(Get.find()));
//     Get.lazyPut<OrderController>(() => OrderController(Get.find()));
//     Get.lazyPut<OrderHistoryController>(
//       () => OrderHistoryController(Get.find()),
//     );
//     Get.lazyPut<OrderTrackingController>(
//       () => OrderTrackingController(
//         trackingRepository: Get.find(),
//         orderRepository: Get.find(),
//       ),
//     );
//     Get.lazyPut<CustomerProfileController>(
//       () => CustomerProfileController(Get.find()),
//     );
//   }
// }

// lib/app/bindings/customer_binding.dart
import 'package:get/get.dart';
import 'package:frontend_delpick/features/customer/controllers/home_controller.dart';
import 'package:frontend_delpick/features/customer/controllers/cart_controller.dart';
import 'package:frontend_delpick/features/customer/controllers/order_controller.dart';
import 'package:frontend_delpick/features/customer/controllers/store_controller.dart';
import 'package:frontend_delpick/data/repositories/store_repository.dart';
import 'package:frontend_delpick/data/repositories/menu_repository.dart';
import 'package:frontend_delpick/data/repositories/order_repository.dart';
import 'package:frontend_delpick/data/repositories/tracking_repository.dart'; // Add this
import 'package:frontend_delpick/data/providers/store_provider.dart';
import 'package:frontend_delpick/data/providers/menu_provider.dart';
import 'package:frontend_delpick/data/providers/order_provider.dart';
import 'package:frontend_delpick/data/providers/tracking_provider.dart'; // Add this

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut<StoreProvider>(() => StoreProvider());
    Get.lazyPut<MenuProvider>(() => MenuProvider());
    Get.lazyPut<OrderProvider>(() => OrderProvider());
    Get.lazyPut<TrackingProvider>(() => TrackingProvider()); // Add this

    // Repositories
    Get.lazyPut<StoreRepository>(() => StoreRepository(Get.find()));
    Get.lazyPut<MenuRepository>(() => MenuRepository(Get.find()));
    Get.lazyPut<OrderRepository>(() => OrderRepository(Get.find()));
    Get.lazyPut<TrackingRepository>(
      () => TrackingRepository(Get.find()),
    ); // Add this

    // Controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<OrderController>(() => OrderController(Get.find()));
    Get.lazyPut<StoreController>(
      () => StoreController(
        storeRepository: Get.find(),
        locationService: Get.find(),
      ),
    );
  }
}
