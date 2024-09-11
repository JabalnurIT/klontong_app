part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  final api = API();
  final imagePicker = ImagePicker();
  final filePicker = FilePicker.platform;

  await _initCore(
      prefs: prefs,
      dio: dio,
      api: api,
      imagePicker: imagePicker,
      filePicker: filePicker);

  await _initProvisioning();
}

Future<void> _initCore({
  required SharedPreferences prefs,
  required Dio dio,
  required API api,
  required ImagePicker imagePicker,
  required FilePicker filePicker,
}) async {
  sl
    ..registerLazySingleton(() => dio)
    ..registerLazySingleton(() => api)
    ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(() => imagePicker)
    ..registerLazySingleton(() => filePicker);
}

Future<void> _initProvisioning() async {
  sl
    ..registerFactory(
      () => ProvisioningBloc(),
    )
    ..registerLazySingleton(() => AddProduct(sl()))
    ..registerLazySingleton(() => GetAllProducts(sl()))
    ..registerLazySingleton(() => GetProductById(sl()))
    ..registerLazySingleton<ProvisioningRepository>(
        () => ProvisioningRepositoryImpl(sl()))
    ..registerLazySingleton<ProvisioningRemoteDataSource>(
      () => ProvisioningRemoteDataSourceImpl(
        dio: sl(),
        api: sl(),
      ),
    );
}
