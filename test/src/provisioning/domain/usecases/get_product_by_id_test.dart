import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';
import 'package:klontong_app/src/provisioning/domain/repositories/provisioning_repository.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/get_product_by_id.dart';
import 'package:mocktail/mocktail.dart';

import 'provisioing_repository.mock.dart';

void main() {
  late ProvisioningRepository repository;
  late GetProductById usecase;

  setUp(() {
    repository = MockProvisioningRepo();
    usecase = GetProductById(repository);
  });

  const tProduct = Product.empty();

  test(
    'should call the [ProvisioningRepo.getProductById]',
    () async {
      when(
        () => repository.getProductById(id: any(named: 'id')),
      ).thenAnswer(
        (_) async => const Right(tProduct),
      );

      final result = await usecase(
        "1",
      );

      expect(result, equals(const Right<dynamic, Product>(tProduct)));

      verify(() => repository.getProductById(
            id: any(named: 'id'),
          )).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
