import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_pref.dart';
import '../../../providers.dart';

class SettingsPage extends ConsumerWidget{
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref){
    final pref = ref.watch(userPrefProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          const Text('퍼스널 톤'),
          const SizedBox(height: 8),
          SegmentedButton<PersonalTone>(
            segments: const [
              ButtonSegment(value: PersonalTone.none, label: Text('없음')),
              ButtonSegment(value: PersonalTone.cool, label: Text('쿨톤')),
              ButtonSegment(value: PersonalTone.warm, label: Text('웜톤')),
            ],
            selected: {pref.tone},
            onSelectionChanged: (s)=> ref.read(userPrefProvider.notifier).setTone(s.first),
          ),
          const SizedBox(height: 12),
          const Text('설정은 로컬에 저장됩니다.'),
        ]),
      ),
    );
  }
}
