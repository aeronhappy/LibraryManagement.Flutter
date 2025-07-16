import 'package:flutter/material.dart';
import 'package:library_management/injection/injection_container.dart' as di;
import 'package:library_management/pages/main_navbar_page.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Management',
      debugShowCheckedModeBanner: false,
      home: MainNavbarPage(),
    );
  }
}
