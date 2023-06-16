import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

void main() async {
  runApp(const MyApp());
}

final FlutterAppAuth appAuth = FlutterAppAuth();

final AuthorizationTokenRequest tokenRequest = AuthorizationTokenRequest(
  'interno_cliente_test',
  'io.tia.interno://login-callback', //'https://interno.tia.com.ec/authentication/login',
  issuer: 'http://pedidosdomicilio.tia.com.ec:9080/auth/realms/interno_test/',
  scopes: ['openid', 'profile', 'email'],
  allowInsecureConnections: true, // Ajusta los scopes según tus necesidades
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Keycloak Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlutterKeycloakExample('Flutter Keycloak Example'),
    );
  }
}

class FlutterKeycloakExample extends StatefulWidget {
  final String title;

  const FlutterKeycloakExample(this.title, {Key? key}) : super(key: key);

  @override
  FlutterKeycloakExampleState createState() => FlutterKeycloakExampleState();
}

class FlutterKeycloakExampleState extends State<FlutterKeycloakExample> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
              ),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () async {
                  requestAuth(tokenRequest);
                  setState(() {});
                },
                child: const Text("Iniciar Sesion"),
              ),
            ],
          ),
        ));
  }

  void requestAuth(AuthorizationTokenRequest tokenRequest) async {
    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(tokenRequest);

    if (result != null && result.accessToken != null) {
      // La autenticación fue exitosa, obtén el token de acceso y otros datos del resultado.
      final String? accessToken = result.accessToken;
      final String? refreshToken = result.refreshToken;
      final DateTime? tokenExpiration = result.accessTokenExpirationDateTime;

      // Usa los kens para acceder a recursos protegidos en tu aplicación móvil.
      print("si");
      print(result.tokenType);
      print(accessToken);
      print(refreshToken);
      print(tokenExpiration);
      print(result.authorizationAdditionalParameters);
      print(result.idToken);
      print(result.scopes);

      print(result.tokenAdditionalParameters);
      controller.text = accessToken!;
    } else {
      // La autenticación falló o el usuario canceló el inicio de sesión.
      print("no");
    }
  }
}
