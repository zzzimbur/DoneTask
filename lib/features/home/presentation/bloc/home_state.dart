// ============================================================================
// ФАЙЛ: HOME STATE - СОСТОЯНИЯ ДЛЯ BLOCA ГЛАВНОЙ СТРАНИЦЫ
// ============================================================================
// ОТВЕЧАЕТ ЗА: Определение всех возможных состояний главной страницы
//              и хранение данных, необходимых для отображения
// ============================================================================

import 'package:equatable/equatable.dart';
import '../../data/models/order_model.dart';

// ============================================================================
// АБСТРАКТНЫЙ БАЗОВЫЙ КЛАСС ДЛЯ ВСЕХ СОСТОЯНИЙ
// ============================================================================
// Все состояния должны наследоваться от этого класса для корректной работы
// с пакетом equatable (сравнение объектов)
// ============================================================================
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

// ============================================================================
// НАЧАЛЬНОЕ СОСТОЯНИЕ
// ============================================================================
// Используется при первом запуске экрана, до загрузки данных
// ============================================================================
class HomeInitial extends HomeState {}

// ============================================================================
// СОСТОЯНИЕ: ЗАГРУЗКА
// ============================================================================
// Показывается во время загрузки данных с сервера
// ============================================================================
class HomeLoading extends HomeState {}

// ============================================================================
// СОСТОЯНИЕ: ЗАГРУЖЕНО
// ============================================================================
// Содержит:
//   - Список заказов
//   - Статистику (активные, сегодня, бюджет)
//   - Фильтры и сортировку (если применялись)
// ============================================================================
class HomeLoaded extends HomeState {
  final List<OrderModel> orders;
  final int activeCount;
  final int todayCount;
  final double totalBudget;
  
  // Дополнительные поля для фильтров и сортировки
  final String? filterCategory;
  final double? filterMinPrice;
  final double? filterMaxPrice;
  final int? filterMinDays;
  final int? filterMaxDays;
  final String? sortBy;

  const HomeLoaded({
    required this.orders,
    required this.activeCount,
    required this.todayCount,
    required this.totalBudget,
    this.filterCategory,
    this.filterMinPrice,
    this.filterMaxPrice,
    this.filterMinDays,
    this.filterMaxDays,
    this.sortBy,
  });

  @override
  List<Object?> get props => [
        orders,
        activeCount,
        todayCount,
        totalBudget,
        filterCategory,
        filterMinPrice,
        filterMaxPrice,
        filterMinDays,
        filterMaxDays,
        sortBy,
      ];

  // ============================================================================
  // МЕТОД: КОПИРОВАНИЕ С ИЗМЕНЕНИЯМИ
  // ============================================================================
  // Позволяет создать копию состояния с измененными полями
  // Используется при обновлении части данных
  // ============================================================================
  HomeLoaded copyWith({
    List<OrderModel>? orders,
    int? activeCount,
    int? todayCount,
    double? totalBudget,
    String? filterCategory,
    double? filterMinPrice,
    double? filterMaxPrice,
    int? filterMinDays,
    int? filterMaxDays,
    String? sortBy,
  }) {
    return HomeLoaded(
      orders: orders ?? this.orders,
      activeCount: activeCount ?? this.activeCount,
      todayCount: todayCount ?? this.todayCount,
      totalBudget: totalBudget ?? this.totalBudget,
      filterCategory: filterCategory ?? this.filterCategory,
      filterMinPrice: filterMinPrice ?? this.filterMinPrice,
      filterMaxPrice: filterMaxPrice ?? this.filterMaxPrice,
      filterMinDays: filterMinDays ?? this.filterMinDays,
      filterMaxDays: filterMaxDays ?? this.filterMaxDays,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

// ============================================================================
// СОСТОЯНИЕ: ОШИБКА
// ============================================================================
// Используется при возникновении ошибки загрузки данных
// ============================================================================
class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}