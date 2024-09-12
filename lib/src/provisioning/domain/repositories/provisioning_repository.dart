import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';

abstract class ProvisioningRepository {
  const ProvisioningRepository();

  ResultVoid addProduct({
    required Product product,
  });

  ResultFuture<List<Product>> getAllProducts();

  ResultFuture<Product> getProductById({
    required String id,
  });

  ResultFuture<Product> updateProduct({
    required Product product,
  });

  ResultVoid deleteProduct({
    required String id,
  });
}
