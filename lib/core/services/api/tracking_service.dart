// lib/core/services/api/tracking_service.dart
import 'package:dio/dio.dart';
import 'package:frontend_delpick/core/services/api/api_service.dart';
import 'package:frontend_delpick/core/constants/api_endpoints.dart';

class TrackingApiService {
  final ApiService _apiService;

  TrackingApiService(this._apiService);

  Future<Response> getTrackingInfo(int orderId) async {
    return await _apiService.get('${ApiEndpoints.tracking}/$orderId');
  }

  Future<Response> startDelivery(int orderId) async {
    return await _apiService.put('${ApiEndpoints.tracking}/$orderId/start');
  }

  Future<Response> completeDelivery(int orderId) async {
    return await _apiService.put('${ApiEndpoints.tracking}/$orderId/complete');
  }
}
