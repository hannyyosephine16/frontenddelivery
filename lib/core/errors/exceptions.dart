// Base Exception Class
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  AppException(this.message, {this.code, this.data});

  @override
  String toString() => 'AppException: $message';
}

// Network Exceptions
class NetworkException extends AppException {
  NetworkException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class ConnectionException extends NetworkException {
  ConnectionException([String? message])
    : super(
        message ?? 'Connection failed. Please check your internet connection.',
      );
}

class TimeoutException extends NetworkException {
  TimeoutException([String? message])
    : super(message ?? 'Request timeout. Please try again.');
}

class ServerException extends NetworkException {
  final int statusCode;

  ServerException(this.statusCode, String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

// Authentication Exceptions
class AuthException extends AppException {
  AuthException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class UnauthorizedException extends AuthException {
  UnauthorizedException([String? message])
    : super(message ?? 'Unauthorized access. Please login again.');
}

class ForbiddenException extends AuthException {
  ForbiddenException([String? message])
    : super(
        message ??
            'Access denied. You don\'t have permission to perform this action.',
      );
}

class TokenExpiredException extends AuthException {
  TokenExpiredException([String? message])
    : super(message ?? 'Session expired. Please login again.');
}

// Validation Exceptions
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;

  ValidationException(String message, {this.errors, String? code})
    : super(message, code: code, data: errors);
}

class RequiredFieldException extends ValidationException {
  RequiredFieldException(String fieldName) : super('$fieldName is required');
}

class InvalidFormatException extends ValidationException {
  InvalidFormatException(String fieldName, String expectedFormat)
    : super('Invalid format for $fieldName. Expected: $expectedFormat');
}

// Data Exceptions
class DataException extends AppException {
  DataException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class NotFoundException extends DataException {
  NotFoundException(String resource) : super('$resource not found');
}

class AlreadyExistsException extends DataException {
  AlreadyExistsException(String resource) : super('$resource already exists');
}

class DataParsingException extends DataException {
  DataParsingException([String? message])
    : super(message ?? 'Failed to parse data');
}

// Location Exceptions
class LocationException extends AppException {
  LocationException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class LocationPermissionDeniedException extends LocationException {
  LocationPermissionDeniedException()
    : super('Location permission denied. Please enable location access.');
}

class LocationServiceDisabledException extends LocationException {
  LocationServiceDisabledException()
    : super('Location service is disabled. Please enable GPS.');
}

class LocationTimeoutException extends LocationException {
  LocationTimeoutException()
    : super('Failed to get location. Please try again.');
}

// Storage Exceptions
class StorageException extends AppException {
  StorageException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class CacheException extends StorageException {
  CacheException([String? message])
    : super(message ?? 'Cache operation failed');
}

class DatabaseException extends StorageException {
  DatabaseException([String? message])
    : super(message ?? 'Database operation failed');
}

// File Exceptions
class FileException extends AppException {
  FileException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class FileNotFoundException extends FileException {
  FileNotFoundException(String fileName) : super('File not found: $fileName');
}

class FileSizeExceededException extends FileException {
  FileSizeExceededException(int maxSize)
    : super('File size exceeds maximum limit of ${maxSize}MB');
}

class UnsupportedFileTypeException extends FileException {
  UnsupportedFileTypeException(String fileType)
    : super('Unsupported file type: $fileType');
}

// Permission Exceptions
class PermissionException extends AppException {
  PermissionException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class CameraPermissionDeniedException extends PermissionException {
  CameraPermissionDeniedException()
    : super('Camera permission denied. Please enable camera access.');
}

class StoragePermissionDeniedException extends PermissionException {
  StoragePermissionDeniedException()
    : super('Storage permission denied. Please enable storage access.');
}

class NotificationPermissionDeniedException extends PermissionException {
  NotificationPermissionDeniedException()
    : super('Notification permission denied. Please enable notifications.');
}

// Business Logic Exceptions
class BusinessLogicException extends AppException {
  BusinessLogicException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class OrderException extends BusinessLogicException {
  OrderException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class PaymentException extends BusinessLogicException {
  PaymentException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class DeliveryException extends BusinessLogicException {
  DeliveryException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

// Cart Exceptions
class CartException extends BusinessLogicException {
  CartException(String message, {String? code, dynamic data})
    : super(message, code: code, data: data);
}

class EmptyCartException extends CartException {
  EmptyCartException() : super('Cart is empty. Please add items to proceed.');
}

class CartItemNotFoundException extends CartException {
  CartItemNotFoundException() : super('Item not found in cart.');
}

class StoreConflictException extends CartException {
  StoreConflictException()
    : super('Cannot add items from different stores. Please clear cart first.');
}

// Unknown Exception
class UnknownException extends AppException {
  UnknownException([String? message])
    : super(message ?? 'An unknown error occurred. Please try again.');
}
