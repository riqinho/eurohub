import 'package:eurohub/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Eurohub',
      initialRoute: Routes.login,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
