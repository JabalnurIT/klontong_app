import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_app/core/errors/exceptions.dart';
import 'package:klontong_app/core/services/api.dart';
import 'package:klontong_app/src/provisioning/data/datasources/provisioning_remote_data_source.dart';
import 'package:klontong_app/src/provisioning/data/models/product_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late API api;
  late ProvisioningRemoteDataSourceImpl dataSource;
  const tProduct = ProductModel.empty();

  final tProducts = List.generate(
    100,
    (index) => ProductModel.empty(id: index.toString()),
  );

  setUp(() {
    dio = MockDio();
    api = API();
    dataSource = ProvisioningRemoteDataSourceImpl(
      dio: dio,
      api: api,
    );
  });

  final tResponseSuccess = Response<dynamic>(
    data: [
      for (final product in tProducts) product.toMap(),
    ],
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseDetailSuccess = Response<dynamic>(
    data: tProduct.toMap(),
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  group(
    'addProduct',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseSuccess);

        final call = dataSource.addProduct;
        expect(
          () => call(product: tProduct),
          returnsNormally,
        );

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);
      });

      test(
        'should throw [ServerException] when [Dio] throws [DioException]',
        () async {
          when(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              data: {'errorMessage': 'Error Occurred'},
            ),
          ));

          final call = dataSource.addProduct;
          expect(
            () => call(product: tProduct),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );

      test(
        'should throw [ServerException] when [Dio] throws [SocketException]',
        () async {
          when(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(const SocketException("Socket Exception"));

          final call = dataSource.addProduct;
          expect(
            () => call(product: tProduct),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );
    },
  );

  group(
    'deleteProducts',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.delete(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseSuccess);

        final call = dataSource.deleteProduct;
        expect(
          () => call(id: "1"),
          returnsNormally,
        );

        verify(
          () => dio.delete(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);
      });

      test(
        'should throw [ServerException] when [Dio] throws [DioException]',
        () async {
          when(
            () => dio.delete(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              data: {'errorMessage': 'Error Occurred'},
            ),
          ));

          final call = dataSource.deleteProduct;
          expect(
            () => call(id: "1"),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.delete(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );

      test(
        'should throw [ServerException] when [Dio] throws [SocketException]',
        () async {
          when(
            () => dio.delete(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(const SocketException("Socket Exception"));

          final call = dataSource.deleteProduct;
          expect(
            () => call(id: "1"),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.delete(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );
    },
  );

  group(
    'getAllProducts',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.get(
            any(),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseSuccess);

        final result = await dataSource.getAllProducts();

        expect(result, equals(tProducts));

        verify(
          () => dio.get(
            any(),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);
      });

      test(
        'should throw [ServerException] when [Dio] throws [DioException]',
        () async {
          when(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              data: {'errorMessage': 'Error Occurred'},
            ),
          ));

          final call = dataSource.getAllProducts;
          expect(
            () => call(),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );

      test(
        'should throw [ServerException] when [Dio] throws [SocketException]',
        () async {
          when(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).thenThrow(const SocketException("Socket Exception"));

          final call = dataSource.getAllProducts;
          expect(
            () => call(),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );
    },
  );

  group(
    'getProductById',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.get(
            any(),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseDetailSuccess);

        final result = await dataSource.getProductById(id: '1');

        expect(result, equals(tProduct));

        verify(
          () => dio.get(
            any(),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);
      });

      test(
        'should throw [ServerException] when [Dio] throws [DioException]',
        () async {
          when(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              data: {'errorMessage': 'Error Occurred'},
            ),
          ));

          final call = dataSource.getProductById;
          expect(
            () => call(id: '1'),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );
      test(
        'should throw [ServerException] when [Dio] throws [SocketException]',
        () async {
          when(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).thenThrow(const SocketException("Socket Exception"));

          final call = dataSource.getProductById;
          expect(
            () => call(id: "1"),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.get(
              any(),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );
    },
  );

  group(
    'updateProduct',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.put(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseDetailSuccess);

        final result = await dataSource.updateProduct(
          product: tProduct,
        );

        expect(result, equals(tProduct));

        verify(
          () => dio.put(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);
      });

      test(
        'should throw [ServerException] when [Dio] throws [DioException]',
        () async {
          when(
            () => dio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              data: {'errorMessage': 'Error Occurred'},
            ),
          ));

          final call = dataSource.updateProduct;
          expect(
            () => call(
              product: tProduct,
            ),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );
      test(
        'should throw [ServerException] when [Dio] throws [SocketException]',
        () async {
          when(
            () => dio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(const SocketException("Socket Exception"));

          final call = dataSource.updateProduct;
          expect(
            () => call(
              product: tProduct,
            ),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );
    },
  );
}
