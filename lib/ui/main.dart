import 'package:dragon_ball_flutter/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  
  // Open Hive box for storing JSON string
  await Hive.openBox('dragonball');

  runApp(const MaterialApp(home: MainScreen()));
}

