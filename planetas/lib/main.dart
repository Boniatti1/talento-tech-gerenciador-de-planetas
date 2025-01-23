import 'package:flutter/material.dart';
import 'screens/app.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ThemeData.dark().primaryColor, // Cor da barra de navegação
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Planetas',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
