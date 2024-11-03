import 'package:app_portifolio/demos/liquid-swiper/widgets/slidingImage.animation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

// by Italo Rodri. Dev 2024

/// Classe para dados dos itens do LiquidSwipe
class ItemData {
  final Color color;
  final Color colorTheme;
  final String logo;
  final String text1;
  final String text2;

  ItemData(
      {required this.color,
      required this.colorTheme,
      required this.logo,
      required this.text1,
      required this.text2});
}

/// Página principal do LiquidSwiper
class IntroSlidePage extends StatefulWidget {
  @override
  _IntroSlidePageState createState() => _IntroSlidePageState();
}

class _IntroSlidePageState extends State<IntroSlidePage> {
  int page = 0;
  late LiquidController liquidController;
  late AnimationController _controller;
  late Animation<double> _initialAnimation;
  late Animation<double> _floatingAnimation;

  final List<ItemData> data = [
    ItemData(
        color: Colors.black,
        colorTheme: Colors.white,
        logo: "logo_c6_bank_white.png",
        text1: "Olá, seja bem-vindo",
        text2: "ao C6 Bank"),
    ItemData(
        color: Colors.white,
        colorTheme: Colors.black,
        logo: "logo_c6_bank.png",
        text1: "Conta digital",
        text2: "completa para você!"),
    ItemData(
        color: Colors.black,
        colorTheme: Colors.white,
        logo: "logo_c6_bank_white.png",
        text1: "Investir nunca foi tão",
        text2: "simples e acessível"),
    ItemData(
        color: Colors.white,
        colorTheme: Colors.black,
        logo: "logo_c6_bank.png",
        text1: "Cashback em todas",
        text2: "as suas compras"),
    ItemData(
        color: Colors.black,
        colorTheme: Colors.white,
        logo: "logo_c6_bank_white.png",
        text1: "Cartão de crédito",
        text2: "sem anuidade"),
    ItemData(
        color: Colors.white,
        colorTheme: Colors.black,
        logo: "logo_c6_bank.png",
        text1: "Abra sua conta",
        text2: "hoje mesmo!")
  ];

  ValueNotifier<Color> colorThemeEvent = ValueNotifier<Color>(Colors.white);
  ValueNotifier<int> indexPageEvent = ValueNotifier<int>(0);

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  void _pageChangeCallback(int indexPage) {
    setState(() {
      page = indexPage;
      colorThemeEvent.value = data[indexPage].colorTheme;
      indexPageEvent.value = indexPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return buildItem(context, data[index], index);
            },
            onPageChangeCallback: _pageChangeCallback,
            liquidController: liquidController,
            waveType: WaveType.circularReveal,
            slideIconWidget: ValueListenableBuilder(
                valueListenable: indexPageEvent,
                builder: (context, index, child) {
                  return Icon(Icons.arrow_back_ios,
                      color: index < data.length - 1
                          ? data[index + 1].colorTheme
                          : data[index - 1].colorTheme);
                }),
            positionSlideIcon: 0.8,
            enableSideReveal: true,
            enableLoop: false,
            ignoreUserGestureWhileAnimating: true,
          ),
          ValueListenableBuilder(
              valueListenable: colorThemeEvent,
              builder: (context, Color theme, child) {
                return DotsIndicator(
                    currentPage: page,
                    totalPages: data.length,
                    colorTheme: theme);
              }),
          Align(
              alignment: Alignment.bottomRight,
              child: ValueListenableBuilder(
                  valueListenable: colorThemeEvent,
                  builder: (context, Color theme, child) {
                    return ValueListenableBuilder(
                        valueListenable: indexPageEvent,
                        builder: (context, index, child) {
                          if (index == data.length - 1) {
                            return SkipButton(
                              colorTheme: theme,
                              text: "Continuar",
                              onPressed: () async {},
                            );
                          } else {
                            return SkipButton(
                              colorTheme: theme,
                              text: "Próximo",
                              onPressed: () async {
                                liquidController.animateToPage(
                                    duration: 1000,
                                    page: (liquidController.currentPage + 1) %
                                        data.length);
                              },
                            );
                          }
                        });
                  })),
          Align(
              alignment: Alignment.bottomLeft,
              child: ValueListenableBuilder(
                  valueListenable: colorThemeEvent,
                  builder: (context, Color theme, child) {
                    return ValueListenableBuilder(
                        valueListenable: indexPageEvent,
                        builder: (context, index, child) {
                          if (index > 0) {
                            return SkipButton(
                              colorTheme: theme,
                              text: "Voltar",
                              onPressed: () async {
                                liquidController.jumpToPage(
                                    page: (liquidController.currentPage - 1) %
                                        data.length);
                              },
                            );
                          } else {
                            return Container();
                          }
                        });
                  })),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, ItemData item, int index) {
    return Container(
      color: item.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/${item.logo}',
                      width: 200, fit: BoxFit.contain),
                ],
              )),
          ValueListenableBuilder(
              valueListenable: indexPageEvent,
              builder: (context, int index, child) {
                if (index == 4) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: SlidingImage(
                          imagePath: 'assets/images/cartao_rosa.png'));
                } else {
                  return Container();
                }
              }),
          Column(
            children: [
              Text(item.text1,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600,
                      color: item.colorTheme)),
              Text(item.text2,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600,
                      color: item.colorTheme)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Widget para o indicador de páginas (dots)
class DotsIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color colorTheme;

  DotsIndicator(
      {required this.currentPage,
      required this.totalPages,
      required this.colorTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) =>
              Dot(isSelected: index == currentPage, colorTheme: colorTheme),
        ),
      ),
    );
  }
}

/// Widget para cada ponto do indicador de página
class Dot extends StatelessWidget {
  final bool isSelected;
  final Color colorTheme;

  Dot({required this.isSelected, required this.colorTheme});

  @override
  Widget build(BuildContext context) {
    double size = isSelected ? 10.0 : 8.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isSelected ? colorTheme : colorTheme.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Botão para "Pular" e "Próximo"
class SkipButton extends StatelessWidget {
  final String text;
  final Color colorTheme;
  final VoidCallback onPressed;

  SkipButton(
      {required this.text, required this.colorTheme, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontFamily: 'Manrope'),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.01),
          foregroundColor: colorTheme,
        ),
      ),
    );
  }
}
