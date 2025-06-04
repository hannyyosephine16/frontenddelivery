import 'package:get/get.dart';
import 'package:frontend_delpick/data/repositories/auth_repository.dart';
import 'package:frontend_delpick/data/providers/auth_provider.dart';
import 'package:frontend_delpick/data/datasources/remote/auth_remote_datasource.dart';
import 'package:frontend_delpick/data/datasources/local/auth_local_datasource.dart';
import 'package:frontend_delpick/features/auth/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource(Get.find()));
    Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSource(Get.find()));

    // Provider
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(
        remoteDataSource: Get.find(),
        localDataSource: Get.find(),
      ),
    );

    // Repository
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));

    // Controllers
    Get.lazyPut<AuthController>(() => AuthController(Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
    Get.lazyPut<RegisterController>(() => RegisterController(Get.find()));
    Get.lazyPut<ForgetPasswordController>(
      () => ForgetPasswordController(Get.find()),
    );
    Get.lazyPut<ProfileController>(() => ProfileController(Get.find()));
  }
}
