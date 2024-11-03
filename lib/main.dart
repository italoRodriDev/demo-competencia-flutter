import 'package:app_portifolio/demos/liquid-swiper/intro_slide.page.dart';
import 'package:app_portifolio/demos/liquid-swiper/splash_bank.page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demos Italo Rodri. Dev.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashBankPage(),
    );
  }
}