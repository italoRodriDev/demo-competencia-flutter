import 'package:flutter/material.dart';

class SlidingBottomImage extends StatefulWidget {
  final String imagePath;
  final double? width;

  const SlidingBottomImage({Key? key, required this.imagePath, this.width})
      : super(key: key);

  @override
  _SlidingBottomImageState createState() => _SlidingBottomImageState();
}

class _SlidingBottomImageState extends State<SlidingBottomImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _initialAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 5), // Duração total da animação inicial
      vsync: this,
    );

    // Animação inicial: de fora da tela abaixo até o centro
    _initialAnimation = Tween<double>(begin: 1.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linearToEaseOut,
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
    _rotationAnimation = Tween<double>(begin: -0.10, end: 0.10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Iniciar a animação inicial
    _controller.forward().then((_) {
      // A partir do final da animação inicial, repetir a animação flutuante e de rotação indefinidamente
      _controller.repeat(reverse: true);
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
        double offsetY = MediaQuery.of(context).size.height *
            _initialAnimation.value; // Posição Y inicial
        double floatY = _floatingAnimation.value; // Movimento flutuante
        double rotation = _rotationAnimation.value; // Rotação

        return Transform.translate(
          offset: Offset(0.0, offsetY + floatY), // Mova no eixo Y
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
