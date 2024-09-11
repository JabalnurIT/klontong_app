import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/provisioning_repository.dart';

class AddProduct implements UsecaseWithParams<void, Product> {
  const AddProduct(this._repository);

  final ProvisioningRepository _repository;

  @override
  ResultVoid call(Product product) => _repository.addProduct(
        product: product,
      );
}
