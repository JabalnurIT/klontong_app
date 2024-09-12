import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/provisioning_repository.dart';

class DeleteProduct implements UsecaseWithParams<void, String> {
  const DeleteProduct(this._repository);

  final ProvisioningRepository _repository;

  @override
  ResultVoid call(String id) => _repository.deleteProduct(
        id: id,
      );
}
