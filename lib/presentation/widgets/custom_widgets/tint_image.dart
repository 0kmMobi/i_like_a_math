import 'package:flutter/material.dart';

class TintImage extends StatelessWidget {
  final String imgPath;
  final int imgColor;
  const TintImage({Key? key, required this.imgPath, required this.imgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.modulate,
      shaderCallback: (Rect bounds) =>
          LinearGradient(colors: [Color(imgColor), Color(imgColor)])
              .createShader(bounds),
      child: Image.asset(imgPath),
    );
  }
}
