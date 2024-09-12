import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/update_product.dart';

part 'provisioning_event.dart';
part 'provisioning_state.dart';

class ProvisioningBloc extends Bloc<ProvisioningEvent, ProvisioningState> {
  ProvisioningBloc({
    required AddProduct addProduct,
    required DeleteProduct deleteProduct,
    required GetAllProducts getAllProducts,
    required GetProductById getProductById,
    required UpdateProduct updateProduct,
  })  : _addProduct = addProduct,
        _deleteProduct = deleteProduct,
        _getAllProducts = getAllProducts,
        _getProductById = getProductById,
        _updateProduct = updateProduct,
        super(const ProvisioningInitial()) {
    on<ProvisioningEvent>((event, emit) {
      emit(const ProvisioningLoading());
    });
    on<AddProductEvent>(_addProductHandler);
    on<DeleteProductEvent>(_deleteProductHandler);
    on<GetAllProductsEvent>(_getAllProductsHandler);
    on<GetProductByIdEvent>(_getProductByIdHandler);
    on<UpdateProductEvent>(_updateProductHandler);
  }
  final AddProduct _addProduct;
  final DeleteProduct _deleteProduct;
  final GetAllProducts _getAllProducts;
  final GetProductById _getProductById;
  final UpdateProduct _updateProduct;

  Future<void> _addProductHandler(
    AddProductEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _addProduct(event.product);
    result.fold(
      (failure) => emit(ProvisioningError(message: failure.errorMessage)),
      (_) => emit(const ProductAdded()),
    );
  }

  Future<void> _deleteProductHandler(
    DeleteProductEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _deleteProduct(event.id);
    result.fold(
      (failure) => emit(ProvisioningError(message: failure.errorMessage)),
      (_) => emit(const ProductDeleted()),
    );
  }

  Future<void> _getAllProductsHandler(
    GetAllProductsEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _getAllProducts();
    result.fold(
      (failure) => emit(ProvisioningError(message: failure.errorMessage)),
      (products) => emit(ProductsLoaded(products: products)),
    );
  }

  Future<void> _getProductByIdHandler(
    GetProductByIdEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _getProductById(event.id);
    result.fold(
      (failure) => emit(ProvisioningError(message: failure.errorMessage)),
      (product) => emit(ProductLoaded(product: product)),
    );
  }

  Future<void> _updateProductHandler(
    UpdateProductEvent event,
    Emitter<ProvisioningState> emit,
  ) async {
    final result = await _updateProduct(
      event.product,
    );

    result.fold(
      (failure) => emit(ProvisioningError(message: failure.errorMessage)),
      (product) => emit(ProductUpdated(product: product)),
    );
  }
}
