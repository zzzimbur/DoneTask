// ============================================================================
// ФАЙЛ: HOME EVENT - СОБЫТИЯ ДЛЯ BLOCA ГЛАВНОЙ СТРАНИЦЫ
// ============================================================================
// ОТВЕЧАЕТ ЗА: Определение всех возможных событий, которые могут происходить
//              на главной странице (загрузка заказов, поиск, избранное и т.д.)
// ============================================================================

import 'package:equatable/equatable.dart';

// ============================================================================
// АБСТРАКТНЫЙ БАЗОВЫЙ КЛАСС ДЛЯ ВСЕХ СОБЫТИЙ
// ============================================================================
// Все события должны наследоваться от этого класса для корректной работы
// с пакетом equatable (сравнение объектов)
// ============================================================================
abstract class HomeEvent extends Equatable {
  const HomeEvent();
  
  @override
  List<Object?> get props => [];
}

// ============================================================================
// СОБЫТИЯ ГЛАВНОЙ СТРАНИЦЫ
// ============================================================================

// Загрузка списка заказов
class LoadOrders extends HomeEvent {
  const LoadOrders();
}

// Переключение избранного у заказа
class ToggleFavorite extends HomeEvent {
  final String orderId;

  const ToggleFavorite(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

// Поиск заказов по запросу
class SearchOrders extends HomeEvent {
  final String query;

  const SearchOrders(this.query);

  @override
  List<Object?> get props => [query];
}

// Обновление списка заказов (pull-to-refresh)
class RefreshOrders extends HomeEvent {
  const RefreshOrders();
}

// Фильтрация заказов по категории
class FilterOrdersByCategory extends HomeEvent {
  final String category;

  const FilterOrdersByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

// Фильтрация заказов по бюджету
class FilterOrdersByBudget extends HomeEvent {
  final double minPrice;
  final double maxPrice;

  const FilterOrdersByBudget({
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  List<Object?> get props => [minPrice, maxPrice];
}

// Фильтрация заказов по срокам
class FilterOrdersByDeadline extends HomeEvent {
  final int minDays;
  final int maxDays;

  const FilterOrdersByDeadline({
    required this.minDays,
    required this.maxDays,
  });

  @override
  List<Object?> get props => [minDays, maxDays];
}

// Сортировка заказов
class SortOrders extends HomeEvent {
  final String sortBy; // 'newest', 'popular', 'price_low', 'price_high', 'deadline'

  const SortOrders(this.sortBy);

  @override
  List<Object?> get props => [sortBy];
}