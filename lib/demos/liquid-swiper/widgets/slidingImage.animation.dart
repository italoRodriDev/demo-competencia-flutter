import 'package:flutter/material.dart';

class SlidingImage extends StatefulWidget {
  final String imagePath;
  final double? width;

  const SlidingImage({Key? key, required this.imagePath, this.width})
      : super(key: key);

  @override
  _SlidingImageState createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _initialAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _rotationAnimation;
  bool initAnimation = true;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 5), // Duração total da animação inicial
      vsync: this,
    );

    // Animação inicial: de fora da tela à direita até o centro
    _initialAnimation = Tween<double>(begin: 1.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Animação de flutuação para cima e para baixo
    _floatingAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Animação de rotação
    _rotationAnimation = Tween<double>(begin: -0.03, end: 0.03).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Iniciar a animação inicial
    _controller.forward().then((_) {
      // A partir do final da animação inicial, repetir a animação flutuante e de rotação indefinidamente
      _controller.repeat(reverse: true);
      initAnimation = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double offsetX = MediaQuery.of(context).size.width *
            _initialAnimation.value; // Posição X inicial
        double floatY = _floatingAnimation.value; // Movimento flutuante
        double rotation = _rotationAnimation.value; // Rotação

        return Transform.translate(
          offset: Offset(offsetX, floatY),
          child: Transform.rotate(
            angle: rotation,
            child: child,
          ),
        );
      },
      child: Image.asset(widget.imagePath,
          width: widget.width ?? 300), // Carregando a imagem
    );
  }
}
