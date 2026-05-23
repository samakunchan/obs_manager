import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:obs_manager/core/exceptions/exceptions.dart';

/// Configuration options for general REST API networking
class ApiConfig {
  static const String baseUrl = 'https://api.example.com';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}

/// Abstract base service class setting up Dio client and functional request handler
abstract class BaseService {
  BaseService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  late final Dio _dio;

  /// Expose the underlying Dio client for custom options
  @protected
  Dio get client => _dio;

  /// Generic request wrapper executing a network request within a functional try-catch
  @protected
  Future<Either<ExceptionModel, T>> apiCall<T>(Future<T> Function() call) async {
    try {
      final T result = await call();

      return Right(result);
    } on DioException catch (e) {
      return Left(ExceptionModel.fromDioException(e));
    } catch (e) {
      return Left(
        ExceptionModel(
          message: e.toString(),
          exception: 'UnknownException',
          statusCode: 500,
        ),
      );
    }
  }
}

/// Interface specifying REST requests
abstract class ApiImplementation {
  Future<Either<ExceptionModel, T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<ExceptionModel, T>> post<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<ExceptionModel, T>> put<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<ExceptionModel, T>> delete<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });
}

/// General networking implementation layer for Dio requests
class ApiService extends BaseService implements ApiImplementation {
  @override
  Future<Either<ExceptionModel, T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return apiCall<T>(() async {
      final response = await client.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data as T;
    });
  }

  @override
  Future<Either<ExceptionModel, T>> post<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return apiCall<T>(() async {
      final response = await client.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data as T;
    });
  }

  @override
  Future<Either<ExceptionModel, T>> put<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return apiCall<T>(() async {
      final response = await client.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data as T;
    });
  }

  @override
  Future<Either<ExceptionModel, T>> delete<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return apiCall<T>(() async {
      final response = await client.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data as T;
    });
  }
}
