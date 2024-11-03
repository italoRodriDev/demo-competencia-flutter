import 'package:app_portifolio/demos/c6-bank/widgets/slidingImage.animation.dart';
import 'package:app_portifolio/demos/nubank/intro_slide.page.dart';
import 'package:flutter/material.dart';

class SplashNuBankPage extends StatefulWidget {
  const SplashNuBankPage({super.key});

  @override
  State<SplashNuBankPage> createState() => _SplashNuBankPageState();
}

class _SplashNuBankPageState extends State<SplashNuBankPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => IntroSlideNubankPage()))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 130, 10, 209),
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/logo_nu_bank_branco.png',
                width: 150),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: CircularProgressIndicator(color: Colors.white)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'by Italo R. Dev.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Manrope'),
                )),
          )
        ],
      )),
    );
  }
}
