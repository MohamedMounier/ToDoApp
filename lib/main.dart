import 'package:flutter/material.dart';
import 'Cubit/Bloc_Observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/home_page.dart';
void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),
    );
  }
}

