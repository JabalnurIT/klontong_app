import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';
import 'package:klontong_app/src/provisioning/domain/repositories/provisioning_repository.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/update_product.dart';
import 'package:mocktail/mocktail.dart';

import 'provisioing_repository.mock.dart';

void main() {
  late ProvisioningRepository repository;
  late UpdateProduct usecase;

  setUp(() {
    repository = MockProvisioningRepo();
    usecase = UpdateProduct(repository);
  });

  const tProduct = Product.empty();

  setUpAll(() {
    registerFallbackValue(tProduct);
  });

  test(
    'should call the [ProvisioningRepo.updateProduct]',
    () async {
      when(
        () => repository.updateProduct(
          product: any(named: 'product'),
        ),
      ).thenAnswer(
        (_) async => const Right(tProduct),
      );

      final result = await usecase(
        tProduct,
      );

      expect(result, equals(const Right<dynamic, Product>(tProduct)));

      verify(() => repository.updateProduct(
            product: any(named: 'product'),
          )).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
