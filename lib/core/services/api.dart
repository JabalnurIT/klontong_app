import '../utils/constanst.dart';

class API {
  final APIAuth auth;
  final APIProvisioning provisioning;

  API()
      : auth = const APIAuth(),
        provisioning = const APIProvisioning();

  String get baseUrl => kBaseUrl;
}

class APIAuth {
  const APIAuth();

  String get signIn => "$kHost/login";
  String get signUp => "$kHost/register";
  String get logout => "$kHost/logout";
  String get profile => "$kHost/profile";
}

class APIProvisioning {
  const APIProvisioning();

  String get product => "$kHost/product";
}
