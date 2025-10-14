import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers.dart';
import '../widgets/mannequin_painter.dart';
import 'edit_color_sheet.dart';

class DesignerPage extends ConsumerStatefulWidget{
  const DesignerPage({super.key});
  @override ConsumerState<DesignerPage> createState()=> _DesignerPageState();
}

class _DesignerPageState extends ConsumerState<DesignerPage>{
  Color topColor = const Color(0xFF355C7D);
  Color bottomColor = const Color(0xFF777777);

  void _openEditor({required bool editingTop}) async {
    final result = await showModalBottomSheet<Color>(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditColorSheet(initial: editingTop ? topColor : bottomColor),
    );
    if(result!=null){
      setState(()=> editingTop ? topColor = result : bottomColor = result);
    }
  }

  @override
  Widget build(BuildContext context){
    final today = ref.watch(todayRecommendationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('컬러 디자이너'),
        actions: [
          IconButton(icon: const Icon(Icons.colorize), onPressed: ()=> _openEditor(editingTop: true), tooltip: '상의 색 변경'),
          IconButton(icon: const Icon(Icons.format_color_fill_outlined), onPressed: ()=> _openEditor(editingTop: false), tooltip: '하의 색 변경'),
        ],
      ),
      body: Column(
        children:[
          today.when(
            data: (colors)=> Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('오늘의 추천색', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: colors.map((c)=> Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: CircleAvatar(backgroundColor: c, radius: 14),
                    )).toList()),
                  )
                ],
              ),
            ),
            loading: ()=> const SizedBox(height: 0),
            error: (_, __)=> const SizedBox.shrink(),
          ),
          Expanded(
            child: GestureDetector(
              onTap: ()=> _openEditor(editingTop: true),
              onLongPress: ()=> _openEditor(editingTop: false),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomPaint(
                  painter: MannequinPainter(topColor: topColor, bottomColor: bottomColor),
                  child: Container(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
