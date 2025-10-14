import 'package:flutter/material.dart';

HSLColor clampHsl(HSLColor c) => HSLColor.fromAHSL(
  1.0,
  (c.hue % 360 + 360) % 360,
  c.saturation.clamp(0,1),
  c.lightness.clamp(0,1),
);

Color varyLightness(Color base, double delta){
  final h = HSLColor.fromColor(base);
  return clampHsl(h.withLightness((h.lightness + delta).clamp(0,1))).toColor();
}

Color withHueSat(Color base, double hue, double sat){
  final h = HSLColor.fromColor(base);
  return clampHsl(h.withHue(hue).withSaturation(sat)).toColor();
}

Color complement(Color base){
  final h = HSLColor.fromColor(base);
  return clampHsl(h.withHue((h.hue+180)%360)).toColor();
}
