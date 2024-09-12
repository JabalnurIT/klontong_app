import 'package:dartz/dartz.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/provisioning_repository.dart';
import '../datasources/provisioning_remote_data_source.dart';
import '../models/product_model.dart';

class ProvisioningRepositoryImpl implements ProvisioningRepository {
  const ProvisioningRepositoryImpl(this._remoteDataSource);

  final ProvisioningRemoteDataSource _remoteDataSource;

  @override
  ResultVoid addProduct({
    required Product product,
  }) async {
    try {
      await _remoteDataSource.addProduct(
        product: ProductModel.fromEntity(product),
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteProduct({required String id}) async {
    try {
      await _remoteDataSource.deleteProduct(id: id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> getAllProducts() async {
    try {
      final result = await _remoteDataSource.getAllProducts();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Product> getProductById({required String id}) async {
    try {
      final result = await _remoteDataSource.getProductById(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Product> updateProduct({
    required Product product,
  }) async {
    try {
      final result = await _remoteDataSource.updateProduct(
        product: ProductModel.fromEntity(product),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
