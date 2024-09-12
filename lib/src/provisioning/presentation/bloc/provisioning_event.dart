part of 'provisioning_bloc.dart';

sealed class ProvisioningEvent extends Equatable {
  const ProvisioningEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends ProvisioningEvent {
  const AddProductEvent({
    required this.product,
  });

  final Product product;

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProvisioningEvent {
  const DeleteProductEvent({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

class GetAllProductsEvent extends ProvisioningEvent {
  const GetAllProductsEvent();
}

class GetProductByIdEvent extends ProvisioningEvent {
  const GetProductByIdEvent({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

class UpdateProductEvent extends ProvisioningEvent {
  const UpdateProductEvent({
    required this.product,
  });

  final Product product;

  @override
  List<Object> get props => [product];
}
