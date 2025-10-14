import 'color_space.dart';
import 'dart:math';

double deltaE76(LabColor a, LabColor b){
  final dL = a.L-b.L; final da=a.a-b.a; final db=a.b-b.b;
  return sqrt(dL*dL + da*da + db*db);
}
