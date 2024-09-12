import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:klontong_app/core/errors/failure.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/add_product.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/delete_product.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/get_all_products.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/get_product_by_id.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/update_product.dart';
import 'package:klontong_app/src/provisioning/presentation/bloc/provisioning_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAddProduct extends Mock implements AddProduct {}

class MockDeleteProduct extends Mock implements DeleteProduct {}

class MockGetAllProducts extends Mock implements GetAllProducts {}

class MockGetProductById extends Mock implements GetProductById {}

class MockUpdateProduct extends Mock implements UpdateProduct {}

void main() {
  late MockAddProduct addProduct;
  late MockDeleteProduct deleteProduct;
  late MockGetAllProducts getAllProducts;
  late MockGetProductById getProductById;
  late MockUpdateProduct updateProduct;
  late ProvisioningBloc provisioningBloc;

  setUp(() {
    addProduct = MockAddProduct();
    deleteProduct = MockDeleteProduct();
    getAllProducts = MockGetAllProducts();
    getProductById = MockGetProductById();
    updateProduct = MockUpdateProduct();
    provisioningBloc = ProvisioningBloc(
      addProduct: addProduct,
      deleteProduct: deleteProduct,
      getAllProducts: getAllProducts,
      getProductById: getProductById,
      updateProduct: updateProduct,
    );
  });

  tearDown(() => provisioningBloc.close());

  test('InitialState must be [AuthInitial]', () {
    expect(provisioningBloc.state, const ProvisioningInitial());
  });

  const tServerFailure = ServerFailure(
    message:
        'There is no user record corresponding to this identifier. The user may have been deleted.',
    statusCode: '404',
  );

  const tProduct = Product.empty();

  setUpAll(() {
    registerFallbackValue(tProduct);
  });

  group('AddProductEvent', () {
    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProductAdded] when [AddProductEvent] is added",
      build: () {
        when(() => addProduct(any()))
            .thenAnswer((_) async => const Right(null));
        return provisioningBloc;
      },
      act: (bloc) async {
        bloc.add(
          const AddProductEvent(
            product: tProduct,
          ),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        const ProductAdded(),
      ],
      verify: (_) {
        verify(() => addProduct(tProduct)).called(1);
        verifyNoMoreInteractions(addProduct);
      },
    );

    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProvisioningError] when [AddProductEvent] fails",
      build: () {
        when(() => addProduct(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return provisioningBloc;
      },
      act: (bloc) {
        bloc.add(
          const AddProductEvent(
            product: tProduct,
          ),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        ProvisioningError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => addProduct(tProduct)).called(1);
        verifyNoMoreInteractions(addProduct);
      },
    );
  });

  // delete group
  group('DeleteProductEvent', () {
    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProductDeleted] when [DeleteProductEvent] is added",
      build: () {
        when(() => deleteProduct(any()))
            .thenAnswer((_) async => const Right(null));
        return provisioningBloc;
      },
      act: (bloc) async {
        bloc.add(
          const DeleteProductEvent(id: '1'),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        const ProductDeleted(),
      ],
      verify: (_) {
        verify(() => deleteProduct('1')).called(1);
        verifyNoMoreInteractions(deleteProduct);
      },
    );

    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProvisioningError] when [DeleteProductEvent] fails",
      build: () {
        when(() => deleteProduct(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return provisioningBloc;
      },
      act: (bloc) {
        bloc.add(
          const DeleteProductEvent(id: '1'),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        ProvisioningError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => deleteProduct('1')).called(1);
        verifyNoMoreInteractions(deleteProduct);
      },
    );
  });

  group('GetAllProductsEvent', () {
    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProductsLoaded] when [GetAllProductsEvent] is added",
      build: () {
        when(() => getAllProducts())
            .thenAnswer((_) async => const Right([tProduct]));
        return provisioningBloc;
      },
      act: (bloc) async {
        bloc.add(
          const GetAllProductsEvent(),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        const ProductsLoaded(products: [tProduct]),
      ],
      verify: (_) {
        verify(() => getAllProducts()).called(1);
        verifyNoMoreInteractions(getAllProducts);
      },
    );

    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProvisioningError] when [GetAllProductsEvent] fails",
      build: () {
        when(() => getAllProducts())
            .thenAnswer((_) async => const Left(tServerFailure));
        return provisioningBloc;
      },
      act: (bloc) {
        bloc.add(
          const GetAllProductsEvent(),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        ProvisioningError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getAllProducts()).called(1);
        verifyNoMoreInteractions(getAllProducts);
      },
    );
  });

  group('GetProductByIdEvent', () {
    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProductLoaded] when [GetProductByIdEvent] is added",
      build: () {
        when(() => getProductById(any()))
            .thenAnswer((_) async => const Right(tProduct));
        return provisioningBloc;
      },
      act: (bloc) async {
        bloc.add(
          const GetProductByIdEvent(id: '1'),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        const ProductLoaded(product: tProduct),
      ],
      verify: (_) {
        verify(() => getProductById('1')).called(1);
        verifyNoMoreInteractions(getProductById);
      },
    );

    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProvisioningError] when [GetProductByIdEvent] fails",
      build: () {
        when(() => getProductById(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return provisioningBloc;
      },
      act: (bloc) async {
        bloc.add(
          const GetProductByIdEvent(id: '1'),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        ProvisioningError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getProductById('1')).called(1);
        verifyNoMoreInteractions(getProductById);
      },
    );
  });

  // update group
  group('UpdateProduct', () {
    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProductUpdated] when [UpdateProductEvent] is added",
      build: () {
        when(() => updateProduct(any()))
            .thenAnswer((_) async => const Right(tProduct));
        return provisioningBloc;
      },
      act: (bloc) async {
        bloc.add(
          const UpdateProductEvent(
            product: tProduct,
          ),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        const ProductUpdated(product: tProduct),
      ],
      verify: (_) {
        verify(() => updateProduct(any())).called(1);
        verifyNoMoreInteractions(getProductById);
      },
    );

    blocTest<ProvisioningBloc, ProvisioningState>(
      "should emit [ProvisioningLoading, ProvisioningError] when [GetProductByIdEvent] fails",
      build: () {
        when(() => updateProduct(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return provisioningBloc;
      },
      act: (bloc) async {
        bloc.add(
          const UpdateProductEvent(
            product: tProduct,
          ),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        ProvisioningError(message: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => updateProduct(any())).called(1);
        verifyNoMoreInteractions(getProductById);
      },
    );
  });
}
