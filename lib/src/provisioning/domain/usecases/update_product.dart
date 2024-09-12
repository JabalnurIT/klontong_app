import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/provisioning_repository.dart';

class UpdateProduct implements UsecaseWithParams<Product, Product> {
  const UpdateProduct(this._repository);

  final ProvisioningRepository _repository;

  @override
  ResultFuture<Product> call(Product product) => _repository.updateProduct(
        product: product,
      );
}
