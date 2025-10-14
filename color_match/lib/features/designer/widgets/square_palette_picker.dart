import 'package:flutter/material.dart';

class SquarePalettePicker extends StatelessWidget{
  final double hue;       // 0..360
  final double lightness; // 0..1
  final ValueChanged<Color> onChanged;
  const SquarePalettePicker({super.key, required this.hue, required this.lightness, required this.onChanged});

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(builder: (ctx, c){
      final size = c.maxHeight;
      return GestureDetector(
        onPanDown: (d)=> _emit(ctx, d.localPosition, size),
        onPanUpdate: (d)=> _emit(ctx, d.localPosition, size),
        child: CustomPaint(
          size: Size.square(size),
          painter: _SquarePainter(hue: hue, lightness: lightness),
        ),
      );
    });
  }

  void _emit(BuildContext ctx, Offset p, double size){
    double x=(p.dx/size).clamp(0,1); // saturation
    final sat = x; // x = saturation
    final c = HSLColor.fromAHSL(1.0, hue, sat, lightness).toColor();
    onChanged(c);
  }
}

class _SquarePainter extends CustomPainter{
  final double hue; final double lightness;
  _SquarePainter({required this.hue, required this.lightness});

  @override
  void paint(Canvas canvas, Size size){
    final rect = Offset.zero & size;
    final Shader baseShader = LinearGradient(
      begin: Alignment.centerLeft, end: Alignment.centerRight,
      colors: [
        HSLColor.fromAHSL(1.0, hue, 0.0, lightness).toColor(),
        HSLColor.fromAHSL(1.0, hue, 1.0, lightness).toColor(),
      ],
    ).createShader(rect);
    canvas.drawRect(rect, Paint()..shader = baseShader);

    final Shader overlayShader = LinearGradient(
      begin: Alignment.topCenter, end: Alignment.bottomCenter,
      colors: [Colors.black.withOpacity(0.25), Colors.transparent],
    ).createShader(rect);
    canvas.drawRect(rect, Paint()..shader = overlayShader);

    final b = Paint()
      ..style=PaintingStyle.stroke
      ..strokeWidth=1
      ..color=Colors.black12;
    canvas.drawRect(rect, b);
  }

  @override
  bool shouldRepaint(covariant _SquarePainter old)=> old.hue!=hue || old.lightness!=lightness;
}
