import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';
import 'package:klontong_app/src/provisioning/domain/repositories/provisioning_repository.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/add_product.dart';
import 'package:mocktail/mocktail.dart';

import 'provisioing_repository.mock.dart';

void main() {
  late ProvisioningRepository repository;
  late AddProduct usecase;

  setUp(() {
    repository = MockProvisioningRepo();
    usecase = AddProduct(repository);
  });

  const tProduct = Product.empty();

  setUpAll(() {
    registerFallbackValue(tProduct);
  });

  test(
    'should call the [ProvisioningRepo.addProduct]',
    () async {
      when(
        () => repository.addProduct(
          product: any(named: 'product'),
          // email: any(named: 'email'),
          // password: any(named: 'password'),,
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tProduct);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.addProduct(
            product: any(named: 'product'),
          )).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
