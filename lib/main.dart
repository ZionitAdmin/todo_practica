import 'package:flutter/material.dart';
import 'package:todo_practica/pages/Home.dart';
import 'package:todo_practica/values/tema.dart';

void main() => runApp(
      MainApp(),
    );

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: miTema(context),
      title: 'Notas App',
      home: HomePage(),
    );
  }
}
