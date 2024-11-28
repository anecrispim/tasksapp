import 'package:flutter/material.dart';
import 'SplashScreen.dart'; // importe o arquivo da splash screen
import 'HomeScreen.dart'; // Importe a HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Define a rota inicial
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(), // Substitua pela sua tela principal
      },
    );
  }
}
