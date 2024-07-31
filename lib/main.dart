import 'package:flutter/material.dart';
import 'login.dart';
import 'dashboard.dart';
import 'api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthService authService = AuthService();
  final email = await authService.getLoggedInEmail();
  runApp(MyApp(startingEmail: email));
}

class MyApp extends StatelessWidget {
  final String? startingEmail;

  MyApp({this.startingEmail});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: startingEmail != null
          ? Dashboard(email: startingEmail!)
          : LoginPage(),
    );
  }
}
