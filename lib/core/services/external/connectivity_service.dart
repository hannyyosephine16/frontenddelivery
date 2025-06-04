import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' as getx;

class ConnectivityService extends getx.GetxService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final getx.RxBool _isConnected = true.obs;
  final getx.Rx<ConnectivityResult> _connectionType =
      ConnectivityResult.none.obs;

  bool get isConnected => _isConnected.value;
  ConnectivityResult get connectionType => _connectionType.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      _isConnected.value = false;
      _connectionType.value = ConnectivityResult.none;
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionType.value = result;
    _isConnected.value = result != ConnectivityResult.none;
  }

  bool get isWifi => _connectionType.value == ConnectivityResult.wifi;
  bool get isMobile => _connectionType.value == ConnectivityResult.mobile;
  bool get isEthernet => _connectionType.value == ConnectivityResult.ethernet;

  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
