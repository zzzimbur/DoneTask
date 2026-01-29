import 'package:flutter/material.dart';
import 'app.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация зависимостей
  di.init();
  
  runApp(const DoneTaskApp());
}