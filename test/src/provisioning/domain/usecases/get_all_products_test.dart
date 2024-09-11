import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';
import 'package:klontong_app/src/provisioning/domain/repositories/provisioning_repository.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/get_all_products.dart';
import 'package:mocktail/mocktail.dart';

import 'provisioing_repository.mock.dart';

void main() {
  late ProvisioningRepository repository;
  late GetAllProducts usecase;

  setUp(() {
    repository = MockProvisioningRepo();
    usecase = GetAllProducts(repository);
  });

  final tProducts = List.generate(
    3,
    (index) => Product.empty(id: index.toString()),
  );

  test(
    'should call the [ProvisioningRepo.getAllProducts]',
    () async {
      when(
        () => repository.getAllProducts(),
      ).thenAnswer(
        (_) async => Right(tProducts),
      );

      final result = await usecase();

      expect(result, equals(Right<dynamic, List<Product>>(tProducts)));

      verify(() => repository.getAllProducts()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
