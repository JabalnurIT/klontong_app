import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/provisioning_repository.dart';

class GetAllProducts implements UsecaseWithoutParams<List<Product>> {
  const GetAllProducts(this._repository);

  final ProvisioningRepository _repository;

  @override
  ResultFuture<List<Product>> call() => _repository.getAllProducts();
}
