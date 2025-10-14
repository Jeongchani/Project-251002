import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers.dart';
import '../../../core/constants/colors_dict_loader.dart';
import '../../../data/models/wear_log.dart';

class CalendarPage extends ConsumerStatefulWidget{
  const CalendarPage({super.key});
  @override ConsumerState<CalendarPage> createState()=> _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage>{
  DateTime _focused = DateTime.now();
  DateTime? _selected;

  @override
  Widget build(BuildContext context){
    final db = ref.read(localDbProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('옷 기록 달력')),
      body: Column(children:[
        TableCalendar(
          firstDay: DateTime.utc(2020,1,1),
          lastDay: DateTime.utc(2035,12,31),
          focusedDay: _focused,
          selectedDayPredicate: (d)=> _selected!=null && isSameDay(d,_selected),
          onDaySelected: (s,f){
            setState((){
              _selected = s;
              _focused = f;
            });
            _openEditSheet(s);
          },
          eventLoader: (day){
            final log = db.getWearByDate(day);
            return log==null ? [] : [log];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (ctx, day, events){
              if(events.isEmpty) return null;
              final WearLog log = events.first as WearLog;
              return Row(mainAxisAlignment: MainAxisAlignment.center, children:[
                if(log.topHex!=null) _dot(hexToColor(log.topHex!)),
                if(log.bottomHex!=null) _dot(hexToColor(log.bottomHex!)),
              ]);
            },
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('날짜를 탭하면 그 날의 상/하의 색을 기록할 수 있어요.', style: Theme.of(context).textTheme.bodySmall),
        )
      ]),
    );
  }

  Widget _dot(Color c)=> Container(width: 6, height: 6, margin: const EdgeInsets.symmetric(horizontal:1), decoration: BoxDecoration(color: c, shape: BoxShape.circle));

  Future<void> _openEditSheet(DateTime day) async {
    final db = ref.read(localDbProvider);
    final existing = db.getWearByDate(day);
    Color? top = existing?.topHex!=null ? hexToColor(existing!.topHex!) : null;
    Color? bottom = existing?.bottomHex!=null ? hexToColor(existing!.bottomHex!) : null;

    await showModalBottomSheet(context: context, isScrollControlled: true, builder: (ctx){
      return StatefulBuilder(builder: (ctx, setState){
        return SafeArea(child: Padding(
          padding: const EdgeInsets.fromLTRB(16,12,16,24),
          child: Column(mainAxisSize: MainAxisSize.min, children:[
            Container(width: 48, height: 4, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 12),
            Row(children:[
              const Text('기록 편집', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const Spacer(),
              if(top!=null) CircleAvatar(backgroundColor: top!, radius: 10),
              const SizedBox(width: 6),
              if(bottom!=null) CircleAvatar(backgroundColor: bottom!, radius: 10),
            ]),
            const SizedBox(height: 12),
            Row(children:[
              Expanded(child: OutlinedButton.icon(onPressed: () async {
                final c = await _pickColor(context, initial: top ?? const Color(0xFF777777));
                if(c!=null) setState(()=> top = c);
              }, icon: const Icon(Icons.checkroom_outlined), label: const Text('상의 색'))),
              const SizedBox(width: 8),
              Expanded(child: OutlinedButton.icon(onPressed: () async {
                final c = await _pickColor(context, initial: bottom ?? const Color(0xFF777777));
                if(c!=null) setState(()=> bottom = c);
              }, icon: const Icon(Icons.storefront_outlined), label: const Text('하의 색'))),
            ]),
            const SizedBox(height: 12),
            Row(children:[
              Expanded(child: OutlinedButton(onPressed: ()=> Navigator.pop(ctx), child: const Text('닫기'))),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(onPressed: () async {
                String? hexFromColor(Color? col){
                  if(col==null) return null;
                  final v = col.value.toRadixString(16).padLeft(8,'0').substring(2).toUpperCase();
                  return '#$v';
                }
                final log = WearLog(date: day, topHex: hexFromColor(top), bottomHex: hexFromColor(bottom));
                await db.upsertWear(log);
                if(mounted) Navigator.pop(ctx);
                setState((){});
              }, child: const Text('저장'))),
            ]),
          ]),
        ));
      });
    });
    if(mounted) setState((){});
  }

  Future<Color?> _pickColor(BuildContext context, {required Color initial}) async {
    HSLColor h = HSLColor.fromColor(initial);
    return showDialog<Color>(context: context, builder: (ctx){
      double hue = h.hue, sat = h.saturation, light = h.lightness;
      Color cur = initial;
      return AlertDialog(
        title: const Text('색 선택'),
        content: SizedBox(
          width: 320,
          child: Column(mainAxisSize: MainAxisSize.min, children:[
            Container(width: 120, height: 24, decoration: BoxDecoration(color: cur, borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 12),
            Slider(min:0,max:360,value:hue,onChanged:(v){ hue=v; cur=HSLColor.fromAHSL(1,hue,sat,light).toColor(); (ctx as Element).markNeedsBuild(); }),
            Slider(min:0,max:1,value:sat,onChanged:(v){ sat=v; cur=HSLColor.fromAHSL(1,hue,sat,light).toColor(); (ctx as Element).markNeedsBuild(); }),
            Slider(min:0,max:1,value:light,onChanged:(v){ light=v; cur=HSLColor.fromAHSL(1,hue,sat,light).toColor(); (ctx as Element).markNeedsBuild(); }),
          ]),
        ),
        actions: [
          TextButton(onPressed: ()=> Navigator.pop(ctx), child: const Text('취소')),
          ElevatedButton(onPressed: ()=> Navigator.pop(ctx, cur), child: const Text('선택')),
        ],
      );
    });
  }
}
