import 'package:flutter_appauth/flutter_appauth.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();

final AuthorizationTokenRequest tokenRequest = AuthorizationTokenRequest(
  'interno_cliente_test',
  '*',
  issuer:
      'http://pedidosdomicilio.tia.com.ec:9080/auth/realms/interno_test/interno_cliente_test/',
  scopes: [
    'openid',
    'profile',
    'email'
  ], // Ajusta los scopes según tus necesidades
);

void requestauth(AuthorizationRequest authorizationRequest) async {
  final AuthorizationTokenResponse? result =
      await appAuth.authorizeAndExchangeCode(tokenRequest);

  if (result != null && result.accessToken != null) {
    // La autenticación fue exitosa, obtén el token de acceso y otros datos del resultado.
    final String? accessToken = result.accessToken;
    final String? refreshToken = result.refreshToken;
    final DateTime? tokenExpiration = result.accessTokenExpirationDateTime;

    // Usa los kens para acceder a recursos protegidos en tu aplicación móvil.
    print("si");
  } else {
    // La autenticación falló o el usuario canceló el inicio de sesión.
    print("no");
  }
}
