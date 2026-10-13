import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/advance_entry.dart';
import 'models/work_day.dart';
import 'pages/home_page.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await StorageService.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => PayDayStore(),
      child: const PayDayApp(),
    ),
  );
}

class PayDayApp extends StatelessWidget {
  const PayDayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayDay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}

class PayDayStore extends ChangeNotifier {
  PayDayStore() {
    _refresh();
  }

  List<WorkDay> workDays = [];
  List<AdvanceEntry> advances = [];

  Future<void> _refresh() async {
    workDays = StorageService.loadWorkDays();
    advances = StorageService.loadAdvances();
    notifyListeners();
  }

  Future<void> addWorkDay(WorkDay workDay) async {
    workDays = [...workDays, workDay];
    workDays.sort((a, b) => a.date.compareTo(b.date));
    await StorageService.saveWorkDays(workDays);
    notifyListeners();
  }

  Future<void> updateAdvance(AdvanceEntry entry) async {
    final index = advances.indexWhere((a) => a.id == entry.id);
    if (index >= 0) {
      advances[index] = entry;
    } else {
      advances.add(entry);
    }
    advances.sort((a, b) => b.date.compareTo(a.date));
    await StorageService.saveAdvances(advances);
    notifyListeners();
  }

  Future<void> addAdvance(AdvanceEntry entry) async {
    advances = [...advances, entry];
    advances.sort((a, b) => b.date.compareTo(a.date));
    await StorageService.saveAdvances(advances);
    notifyListeners();
  }

  Future<void> load() async {
    await _refresh();
  }

  double get totalEarned {
    return workDays.fold<double>(0, (sum, day) => sum + day.total);
  }

  double get approvedAdvances {
    return advances
        .where((a) => a.status == AdvanceStatus.approved)
        .fold<double>(0, (sum, a) => sum + a.amount);
  }

  double get pendingAdvances {
    return advances
        .where((a) => a.status == AdvanceStatus.pending)
        .fold<double>(0, (sum, a) => sum + a.amount);
  }

  double get balance {
    return totalEarned - approvedAdvances;
  }

  List<WorkDay> get itemsForMonth {
    final now = DateTime.now();
    return workDays.where((day) {
      return day.date.year == now.year && day.date.month == now.month;
    }).toList();
  }
}
