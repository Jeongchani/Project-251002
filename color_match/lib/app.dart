import 'package:flutter/material.dart';
import 'features/designer/presentation/designer_page.dart';
import 'features/calendar/presentation/calendar_page.dart';
import 'features/stats/presentation/stats_page.dart';
import 'features/settings/presentation/settings_page.dart';

class App extends StatefulWidget{ const App({super.key});
  @override State<App> createState()=> _AppState(); }

class _AppState extends State<App>{
  int idx = 0;
  @override
  Widget build(BuildContext context){
    final pages = const [DesignerPage(), CalendarPage(), StatsPage(), SettingsPage()];
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF355C7D)),
      home: Scaffold(
        body: pages[idx],
        bottomNavigationBar: NavigationBar(
          selectedIndex: idx,
          onDestinationSelected: (i)=> setState(()=> idx=i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: '홈'),
            NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: '달력'),
            NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: '통계'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: '설정'),
          ],
        ),
      ),
    );
  }
}
