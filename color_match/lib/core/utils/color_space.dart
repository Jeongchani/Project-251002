import 'dart:math';
import 'package:flutter/material.dart';

class LabColor { final double L, a, b; const LabColor(this.L, this.a, this.b); }
double _srgbToLinear(double c) => (c <= 0.04045) ? c/12.92 : pow((c+0.055)/1.055, 2.4).toDouble();
double _linearToSrgb(double c) => (c <= 0.0031308) ? 12.92*c : 1.055*pow(c, 1/2.4)-0.055;

LabColor rgbToLab(Color rgb) {
  final r = _srgbToLinear(rgb.red/255.0);
  final g = _srgbToLinear(rgb.green/255.0);
  final b = _srgbToLinear(rgb.blue/255.0);
  final X = r*0.4124564 + g*0.3575761 + b*0.1804375;
  final Y = r*0.2126729 + g*0.7151522 + b*0.0721750;
  final Z = r*0.0193339 + g*0.1191920 + b*0.9503041;
  const Xn = 0.95047; const Yn = 1.00000; const Zn = 1.08883;
  double f(double t) => t > pow(6/29,3) ? pow(t, 1/3).toDouble() : (t/(3*pow(6/29,2)) + 4/29);
  final fx = f(X/Xn); final fy = f(Y/Yn); final fz = f(Z/Zn);
  final L = 116*fy - 16; final a = 500*(fx-fy); final b2 = 200*(fy-fz);
  return LabColor(L, a, b2);
}

Color labToRgb(LabColor lab) {
  final fy = (lab.L + 16)/116.0; final fx = lab.a/500.0 + fy; final fz = fy - lab.b/200.0;
  double finv(double t) { final t3 = t*t*t; return (t3 > pow(6/29,3)) ? t3 : 3*pow(6/29,2)*(t - 4/29); }
  const Xn = 0.95047; const Yn = 1.00000; const Zn = 1.08883;
  final X = Xn*finv(fx); final Y = Yn*finv(fy); final Z = Zn*finv(fz);
  final rl =  3.2404542*X + -1.5371385*Y + -0.4985314*Z;
  final gl = -0.9692660*X +  1.8760108*Y +  0.0415560*Z;
  final bl =  0.0556434*X + -0.2040259*Y +  1.0572252*Z;
  int to8(double v){ final s=_linearToSrgb(v).clamp(0.0,1.0); return (s*255).round(); }
  return Color.fromARGB(255, to8(rl), to8(gl), to8(bl));
}
