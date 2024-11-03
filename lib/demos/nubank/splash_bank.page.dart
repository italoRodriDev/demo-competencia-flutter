import 'package:app_portifolio/demos/c6-bank/widgets/slidingImage.animation.dart';
import 'package:app_portifolio/demos/nubank/intro_slide.page.dart';
import 'package:flutter/material.dart';

class SplashBankPage extends StatefulWidget {
  const SplashBankPage({super.key});

  @override
  State<SplashBankPage> createState() => _SplashBankPageState();
}

class _SplashBankPageState extends State<SplashBankPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10)).then((value) => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => IntroSlideNubankPage()))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child:
                SlidingImage(imagePath: 'assets/images/logo_c6_bank_white.png'),
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
