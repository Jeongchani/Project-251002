import 'package:flutter/material.dart';
import '../../../core/utils/color_space.dart';
import '../../../core/utils/delta_e.dart';
import '../../../core/utils/hsl_utils.dart';

class RecommendationResult{
  final List<Color> safe;
  final List<Color> mono;
  final List<Color> trendy;
  const RecommendationResult(this.safe, this.mono, this.trendy);
}

class RecommendationService{
  final List<Color> dict; RecommendationService(this.dict);

  Color nearest(Color input){
    final inLab = rgbToLab(input);
    double best = 1e9; Color bestC = dict.first;
    for(final c in dict){
      final d = deltaE76(inLab, rgbToLab(c));
      if(d < best){ best = d; bestC = c; }
    }
    return bestC;
  }

  RecommendationResult recommend(Color base){
    final safeCandidates = <Color>{
      Colors.white, Colors.black, const Color(0xFF1B2A4A), const Color(0xFF777777), const Color(0xFFFFF3D6)
    };
    safeCandidates.add(nearest(varyLightness(base, 0.10)));
    safeCandidates.add(nearest(varyLightness(base, -0.10)));

    final mono = <Color>[
      nearest(varyLightness(base, 0.18)),
      nearest(varyLightness(base, -0.18)),
    ];

    final h = HSLColor.fromColor(base);
    final comp = complement(base);
    final triad1 = withHueSat(base, (h.hue+120)%360, (h.saturation*0.85).clamp(0,1));
    final triad2 = withHueSat(base, (h.hue+240)%360, (h.saturation*0.85).clamp(0,1));

    final trendy = [comp, triad1, triad2].map(nearest).toSet().toList();
    final safe = safeCandidates.toList();
    return RecommendationResult(safe.take(6).toList(), mono.take(6).toList(), trendy.take(6).toList());
  }
}
