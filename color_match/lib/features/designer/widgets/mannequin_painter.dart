import 'package:flutter/material.dart';

class MannequinPainter extends CustomPainter{
  final Color topColor; final Color bottomColor;
  MannequinPainter({required this.topColor, required this.bottomColor});

  @override
  void paint(Canvas canvas, Size size){
    final w=size.width, h=size.height;

    final bg = Paint()..color = const Color(0xFFF7F7F7);
    canvas.drawRect(Rect.fromLTWH(0,0,w,h), bg);

    final cardR = RRect.fromRectAndRadius(Rect.fromLTWH(w*0.08,h*0.05,w*0.84,h*0.9), const Radius.circular(24));
    final cardPaint = Paint()..color = Colors.white;
    canvas.drawRRect(cardR, cardPaint);

    final torso = Path()
      ..moveTo(w*0.35, h*0.22)
      ..quadraticBezierTo(w*0.50, h*0.14, w*0.65, h*0.22)
      ..lineTo(w*0.67, h*0.50)
      ..quadraticBezierTo(w*0.50, h*0.60, w*0.33, h*0.50)
      ..close();
    canvas.drawPath(torso, Paint()..color=topColor.withOpacity(0.98));

    final pants = Path()
      ..moveTo(w*0.33, h*0.50)
      ..lineTo(w*0.47, h*0.90)
      ..lineTo(w*0.53, h*0.90)
      ..lineTo(w*0.67, h*0.50)
      ..close();
    canvas.drawPath(pants, Paint()..color=bottomColor.withOpacity(0.98));
  }

  @override
  bool shouldRepaint(covariant MannequinPainter old)=> old.topColor!=topColor || old.bottomColor!=bottomColor;
}
