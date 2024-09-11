import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/core/utils/typedef.dart';
import 'package:klontong_app/src/provisioning/data/models/product_model.dart';
import 'package:klontong_app/src/provisioning/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tProductModel = ProductModel.empty();

  test('should be a subclass of [Product] entity',
      () => expect(tProductModel, isA<Product>()));

  final tMap = jsonDecode(fixture('product.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [ProductModel] from the Map', () {
      final result = ProductModel.fromMap(tMap);

      expect(result, equals(tProductModel));
    });

    test('should throw an Error when the map is invalid ', () {
      final map = DataMap.from(tMap)..remove('_id');

      const call = ProductModel.fromMap;

      expect(() => call(map), throwsA(isA<Error>()));
    });
  });
  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      final result = tProductModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('fromEntity', () {
    test('should return a valid [ProductModel] from the entity', () {
      final result = ProductModel.fromEntity(tProductModel);

      expect(result, equals(tProductModel));
    });
  });

  group('copyWith', () {
    test('should return a valid [DataModel] with updated value', () {
      final result = tProductModel.copyWith(
        name: 'name',
        price: 2000,
      );

      expect(
        result.name,
        equals('name'),
      );
      expect(
        result.price,
        equals(2000),
      );
    });
  });
}
