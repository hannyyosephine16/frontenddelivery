class ApiEndpoints {
  // Base paths
  static const String auth = '/auth';
  static const String customers = '/customers';
  static const String drivers = '/drivers';
  static const String stores = '/stores';
  static const String menuItems = '/menu-items';
  static const String orders = '/orders';
  static const String driverRequests = '/driver-requests';
  static const String tracking = '/tracking';

  // Auth endpoints
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String logout = '$auth/logout';
  static const String profile = '$auth/profile';
  static const String updateProfile = '$auth/update-profile';
  static const String forgotPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';

  // Customer endpoints
  static const String getAllCustomers = customers;
  static String getCustomerById(int id) => '$customers/$id';
  static const String createCustomer = customers;
  static String updateCustomer(int id) => '$customers/$id';
  static String deleteCustomer(int id) => '$customers/$id';

  // Driver endpoints
  static const String getAllDrivers = drivers;
  static String getDriverById(int id) => '$drivers/$id';
  static const String createDriver = drivers;
  static String updateDriver(int id) => '$drivers/$id';
  static String deleteDriver(int id) => '$drivers/$id';
  static const String updateDriverLocation = '$drivers/location';
  static String getDriverLocation(int driverId) =>
      '$drivers/$driverId/location';
  static const String updateDriverStatus = '$drivers/status';
  static const String updateDriverProfile = '$drivers/update';
  static const String getDriverOrders = '$drivers/orders';

  // Store endpoints
  static const String getAllStores = stores;
  static String getStoreById(int id) => '$stores/$id';
  static const String createStore = stores;
  static String updateStore(int id) => '$stores/$id';
  static String deleteStore(int id) => '$stores/$id';
  static const String updateStoreProfile = '$stores/update';
  static String updateStoreStatus(int id) => '$stores/$id/status';

  // Menu item endpoints
  static const String getAllMenuItems = menuItems;
  static String getMenuItemById(int id) => '$menuItems/$id';
  static String getMenuItemsByStoreId(int storeId) =>
      '$menuItems/store/$storeId';
  static const String createMenuItem = menuItems;
  static String updateMenuItem(int id) => '$menuItems/$id';
  static String deleteMenuItem(int id) => '$menuItems/$id';

  // Order endpoints
  static const String createOrder = orders;
  static const String getUserOrders = '$orders/user';
  static const String getStoreOrders = '$orders/store';
  static String getOrderById(int id) => '$orders/$id';
  static String processOrder(int id) => '$orders/$id/process';
  static String cancelOrder(int id) => '$orders/$id/cancel';
  static const String createReview = '$orders/review';
  static const String updateOrderStatus = '$orders/status';

  // Driver request endpoints
  static const String getDriverRequests = driverRequests;
  static String getDriverRequestById(int id) => '$driverRequests/$id';
  static String respondToDriverRequest(int id) => '$driverRequests/$id/respond';

  // Tracking endpoints
  static String getTrackingData(int orderId) => '$tracking/$orderId';
  static String startDelivery(int orderId) => '$tracking/$orderId/start';
  static String completeDelivery(int orderId) => '$tracking/$orderId/complete';

  // File upload endpoints
  static const String uploadImage = '/upload/image';
  static const String uploadDocument = '/upload/document';

  // Utility endpoints
  static const String healthCheck = '/health';
  static const String version = '/version';

  // Query parameters helpers
  static Map<String, dynamic> getPaginationParams({
    int page = 1,
    int limit = 10,
  }) {
    return {'page': page.toString(), 'limit': limit.toString()};
  }

  static Map<String, dynamic> getSearchParams({
    String? search,
    String? sortBy,
    String? sortOrder,
  }) {
    final params = <String, dynamic>{};
    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      params['sortBy'] = sortBy;
    }
    if (sortOrder != null && sortOrder.isNotEmpty) {
      params['sortOrder'] = sortOrder;
    }
    return params;
  }

  static Map<String, dynamic> getFilterParams({
    String? status,
    int? storeId,
    int? customerId,
    int? driverId,
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? isAvailable,
  }) {
    final params = <String, dynamic>{};
    if (status != null && status.isNotEmpty) {
      params['status'] = status;
    }
    if (storeId != null) {
      params['storeId'] = storeId.toString();
    }
    if (customerId != null) {
      params['customerId'] = customerId.toString();
    }
    if (driverId != null) {
      params['driverId'] = driverId.toString();
    }
    if (category != null && category.isNotEmpty) {
      params['category'] = category;
    }
    if (minPrice != null) {
      params['minPrice'] = minPrice.toString();
    }
    if (maxPrice != null) {
      params['maxPrice'] = maxPrice.toString();
    }
    if (minRating != null) {
      params['minRating'] = minRating.toString();
    }
    if (isAvailable != null) {
      params['isAvailable'] = isAvailable.toString();
    }
    return params;
  }

  static Map<String, dynamic> getLocationParams({
    double? latitude,
    double? longitude,
    double? radius,
  }) {
    final params = <String, dynamic>{};
    if (latitude != null) {
      params['latitude'] = latitude.toString();
    }
    if (longitude != null) {
      params['longitude'] = longitude.toString();
    }
    if (radius != null) {
      params['radius'] = radius.toString();
    }
    return params;
  }
}
