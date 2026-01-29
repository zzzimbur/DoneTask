// ============================================================================
// ФАЙЛ: APP - ГЛАВНОЕ ПРИЛОЖЕНИЕ
// ============================================================================
// ОТВЕЧАЕТ ЗА: Инициализацию всего приложения, настройку темы,
//              маршрутизации и начального экрана
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/home_event.dart';

class DoneTaskApp extends StatelessWidget {
  const DoneTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoneTask',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}