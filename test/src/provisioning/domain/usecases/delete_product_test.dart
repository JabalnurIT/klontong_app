import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/src/provisioning/domain/repositories/provisioning_repository.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/delete_product.dart';
import 'package:mocktail/mocktail.dart';

import 'provisioing_repository.mock.dart';

void main() {
  late ProvisioningRepository repository;
  late DeleteProduct usecase;

  setUp(() {
    repository = MockProvisioningRepo();
    usecase = DeleteProduct(repository);
  });

  test(
    'should call the [ProvisioningRepo.addProduct]',
    () async {
      when(
        () => repository.deleteProduct(
          id: any(named: 'id'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase('1');

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => repository.deleteProduct(
          id: any(named: 'id'),
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
