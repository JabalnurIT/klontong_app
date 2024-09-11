part of 'provisioning_bloc.dart';

sealed class ProvisioningState extends Equatable {
  const ProvisioningState();

  @override
  List<Object> get props => [];
}

final class ProvisioningInitial extends ProvisioningState {
  const ProvisioningInitial();
}

final class ProvisioningLoading extends ProvisioningState {
  const ProvisioningLoading();
}

final class ProvisioningError extends ProvisioningState {
  const ProvisioningError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class ProductAdded extends ProvisioningState {
  const ProductAdded(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

final class ProductLoaded extends ProvisioningState {
  const ProductLoaded(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

final class ProductsLoaded extends ProvisioningState {
  const ProductsLoaded(this.products);

  final List<Product> products;

  @override
  List<Object> get props => [products];
}
