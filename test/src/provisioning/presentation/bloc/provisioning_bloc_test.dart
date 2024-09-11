import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/core/errors/failure.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/add_product.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/get_all_products.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/get_product_by_id.dart';
import 'package:klontong_app/src/provisioning/presentation/bloc/provisioning_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAddProduct extends Mock implements AddProduct {}

class MockGetAllProducts extends Mock implements GetAllProducts {}

class MockGetProductById extends Mock implements GetProductById {}

void main() {
  late MockAddProduct addProduct;
  late MockGetAllProducts getAllProducts;
  late MockGetProductById getProductById;
  late ProvisioningBloc provisioningBloc;

  setUp(() {
    addProduct = MockAddProduct();
    getAllProducts = MockGetAllProducts();
    getProductById = MockGetProductById();
    provisioningBloc = ProvisioningBloc(
      addProduct: addProduct,
      getAllProducts: getAllProducts,
      getProductById: getProductById,
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
        const ProductAdded(tProduct),
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
        ProvisioningError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => addProduct(tProduct)).called(1);
        verifyNoMoreInteractions(addProduct);
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
        const ProductsLoaded([tProduct]),
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
        ProvisioningError(tServerFailure.errorMessage),
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
        const ProductLoaded(tProduct),
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
      act: (bloc) {
        bloc.add(
          const GetProductByIdEvent(id: '1'),
        );
      },
      expect: () => [
        const ProvisioningLoading(),
        ProvisioningError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getProductById('1')).called(1);
        verifyNoMoreInteractions(getProductById);
      },
    );
  });
}
