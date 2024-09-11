import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/provisioning_repository.dart';

class GetProductById implements UsecaseWithParams<Product, String> {
  const GetProductById(this._repository);

  final ProvisioningRepository _repository;

  @override
  ResultFuture<Product> call(String id) => _repository.getProductById(
        id: id,
      );
}
