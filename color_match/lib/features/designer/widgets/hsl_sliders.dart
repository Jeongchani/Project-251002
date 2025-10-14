import 'package:flutter/material.dart';

class HslSliders extends StatelessWidget{
  final double hue, saturation, lightness;
  final void Function(double h,double s,double l) onChanged;
  const HslSliders({super.key, required this.hue, required this.saturation, required this.lightness, required this.onChanged});

  @override
  Widget build(BuildContext context){
    return Column(children:[
      _row('Hue', hue, 0, 360, (v)=> onChanged(v, saturation, lightness)),
      _row('Saturation', saturation, 0, 1, (v)=> onChanged(hue, v, lightness)),
      _row('Lightness', lightness, 0, 1, (v)=> onChanged(hue, saturation, v)),
    ]);
  }

  Widget _row(String label, double value, double min, double max, ValueChanged<double> on){
    return Row(children:[
      SizedBox(width: 90, child: Text(label)),
      Expanded(child: Slider(min: min, max: max, value: value, onChanged: on))
    ]);
  }
}
