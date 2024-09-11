import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_product_by_id.dart';

part 'provisioning_event.dart';
part 'provisioning_state.dart';

class ProvisioningBloc extends Bloc<ProvisioningEvent, ProvisioningState> {
  ProvisioningBloc({
    required AddProduct addProduct,
    required GetAllProducts getAllProducts,
    required GetProductById getProductById,
  })  : _addProduct = addProduct,
        _getAllProducts = getAllProducts,
        _getProductById = getProductById,
        super(const ProvisioningInitial()) {
    on<ProvisioningEvent>((event, emit) {
      emit(const ProvisioningLoading());
    });
    on<AddProductEvent>(_addProductHandler);
    on<GetAllProductsEvent>(_getAllProductsHandler);
    on<GetProductByIdEvent>(_getProductByIdHandler);
  }
  final AddProduct _addProduct;
  final GetAllProducts _getAllProducts;
  final GetProductById _getProductById;

  Future<void> _addProductHandler(
    AddProductEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _addProduct(event.product);
    result.fold(
      (failure) => emit(ProvisioningError(failure.errorMessage)),
      (_) => emit(ProductAdded(event.product)),
    );
  }

  Future<void> _getAllProductsHandler(
    GetAllProductsEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _getAllProducts();
    result.fold(
      (failure) => emit(ProvisioningError(failure.errorMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _getProductByIdHandler(
    GetProductByIdEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _getProductById(event.id);
    result.fold(
      (failure) => emit(ProvisioningError(failure.errorMessage)),
      (product) => emit(ProductLoaded(product)),
    );
  }
}
