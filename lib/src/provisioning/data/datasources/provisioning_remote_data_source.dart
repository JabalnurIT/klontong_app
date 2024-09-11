import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/api.dart';
import '../../../../core/utils/headers.dart';
import '../../../../core/utils/typedef.dart';
import '../models/product_model.dart';

abstract class ProvisioningRemoteDataSource {
  const ProvisioningRemoteDataSource();

  Future<void> addProduct({
    required ProductModel product,
  });

  Future<List<ProductModel>> getAllProducts();

  Future<ProductModel> getProductById({
    required String id,
  });
}

class ProvisioningRemoteDataSourceImpl implements ProvisioningRemoteDataSource {
  const ProvisioningRemoteDataSourceImpl({
    required Dio dio,
    required API api,
  })  : _dio = dio,
        _api = api;

  final Dio _dio;
  final API _api;

  @override
  Future<void> addProduct({required ProductModel product}) async {
    try {
      await _dio.post(
        _api.provisioning.product,
        data: product.toMap(),
        options: Options(
          headers: ApiHeaders.getHeaders().headers,
        ),
      );
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['errorMessage'] as String? ?? "Error Occurred",
        statusCode: e.response?.statusCode ?? 500,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final result = await _dio.get(
        _api.provisioning.product,
        options: Options(
          headers: ApiHeaders.getHeaders().headers,
        ),
      );

      return (result.data as List)
          .map((e) => ProductModel.fromMap(e as DataMap))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['errorMessage'] as String? ?? "Error Occurred",
        statusCode: e.response?.statusCode ?? 500,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ProductModel> getProductById({required String id}) async {
    try {
      final result = await _dio.get(
        "${_api.provisioning.product}/$id",
        options: Options(
          headers: ApiHeaders.getHeaders().headers,
        ),
      );

      return ProductModel.fromMap(result.data['data'] as DataMap);
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['errorMessage'] as String? ?? "Error Occurred",
        statusCode: e.response?.statusCode ?? 500,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
