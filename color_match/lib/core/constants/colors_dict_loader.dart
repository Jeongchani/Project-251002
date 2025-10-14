import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import '../../data/models/color_entry.dart';

Color hexToColor(String hex){
  final v = hex.replaceAll('#','');
  return Color(int.parse('FF$v', radix:16));
}

Future<List<ColorEntry>> loadStandardColors() async {
  final s = await rootBundle.loadString('assets/standard_colors.json');
  final List<dynamic> arr = jsonDecode(s);
  return arr.map((e) => ColorEntry(name: e['name'], hex: e['hex'], group: e['group'])).toList();
}
