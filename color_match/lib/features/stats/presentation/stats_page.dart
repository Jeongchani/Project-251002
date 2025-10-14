import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget{ const StatsPage({super.key});
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('통계')),
      body: const Center(child: Text('자주 쓰는 색 TOP5, 분포 그래프 예정')),
    );
  }
}
