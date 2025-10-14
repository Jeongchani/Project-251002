import 'package:flutter/material.dart';
import '../widgets/square_palette_picker.dart';
import '../widgets/hsl_sliders.dart';

class EditColorSheet extends StatefulWidget{
  final Color initial;
  const EditColorSheet({super.key, required this.initial});
  @override State<EditColorSheet> createState()=> _EditColorSheetState();
}

class _EditColorSheetState extends State<EditColorSheet>{
  late double hue, sat, light;
  late Color current;
  @override
  void initState(){
    super.initState();
    final hsl = HSLColor.fromColor(widget.initial);
    hue = hsl.hue; sat = hsl.saturation; light = hsl.lightness;
    current = widget.initial;
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 48, height: 4, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 12),
            Row(
              children:[
                const Text('색 편집', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const Spacer(),
                CircleAvatar(backgroundColor: current, radius: 12),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(height: 220, child: SquarePalettePicker(
              hue: hue, lightness: light,
              onChanged: (c){ setState(()=> current = c); final h = HSLColor.fromColor(c); hue=h.hue; sat=h.saturation; light=h.lightness; },
            )),
            HslSliders(
              hue: hue, saturation: sat, lightness: light,
              onChanged: (h,s,l){ setState((){ hue=h; sat=s; light=l; current = HSLColor.fromAHSL(1.0,h,s,l).toColor();}); },
            ),
            const SizedBox(height: 8),
            Row(children:[
              Expanded(child: OutlinedButton(onPressed: ()=> Navigator.pop(context), child: const Text('취소'))),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(onPressed: ()=> Navigator.pop<Color>(context, current), child: const Text('적용'))),
            ]),
          ],
        ),
      ),
    );
  }
}
