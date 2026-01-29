// ============================================================================
// ФАЙЛ: ORDER MODEL - МОДЕЛЬ ДАННЫХ ЗАКАЗА
// ============================================================================
// ОТВЕЧАЕТ ЗА: Хранение всех данных, связанных с одним заказом
//              включая информацию о клиенте, бюджете, сроках и т.д.
// ============================================================================

import 'package:equatable/equatable.dart';

// ============================================================================
// КЛАСС: ORDER MODEL
// ============================================================================
// ОПИСАНИЕ ПОЛЕЙ:
//   - id: Уникальный идентификатор заказа
//   - title: Заголовок заказа
//   - description: Описание заказа
//   - price: Бюджет заказа
//   - currency: Валюта (₽, $, € и т.д.)
//   - days: Срок выполнения в днях
//   - clientName: Имя клиента
//   - skills: Требуемые навыки
//   - isFavorite: Добавлен ли в избранное
//   - createdAt: Дата создания заказа
//   - category: Категория заказа (development, design, writing и т.д.)
//   - tags: Дополнительные теги
//   - attachments: Прикрепленные файлы (URL)
//   - urgent: Срочный ли заказ
// ============================================================================

class OrderModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String currency;
  final int days;
  final String clientName;
  final List<String> skills;
  final bool isFavorite;
  final DateTime createdAt;
  final String category;
  final List<String> tags;
  final List<String> attachments;
  final bool urgent;

  const OrderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.days,
    required this.clientName,
    required this.skills,
    this.isFavorite = false,
    required this.createdAt,
    required this.category,
    this.tags = const [],
    this.attachments = const [],
    this.urgent = false,
  });

  // ============================================================================
  // МЕТОД: КОПИРОВАНИЕ С ИЗМЕНЕНИЯМИ
  // ============================================================================
  // Позволяет создать копию модели с измененными полями
  // Используется при обновлении части данных
  // ============================================================================
  OrderModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? currency,
    int? days,
    String? clientName,
    List<String>? skills,
    bool? isFavorite,
    DateTime? createdAt,
    String? category,
    List<String>? tags,
    List<String>? attachments,
    bool? urgent,
  }) {
    return OrderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      days: days ?? this.days,
      clientName: clientName ?? this.clientName,
      skills: skills ?? this.skills,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      attachments: attachments ?? this.attachments,
      urgent: urgent ?? this.urgent,
    );
  }

  // ============================================================================
  // МЕТОД: ИЗ JSON
  // ============================================================================
  // Создает модель из JSON-объекта
  // Используется при десериализации данных с сервера
  // ============================================================================
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency'] ?? '₽',
      days: json['days'] ?? 7,
      clientName: json['clientName'] ?? 'Клиент',
      skills: List<String>.from(json['skills'] ?? []),
      isFavorite: json['isFavorite'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      category: json['category'] ?? 'other',
      tags: List<String>.from(json['tags'] ?? []),
      attachments: List<String>.from(json['attachments'] ?? []),
      urgent: json['urgent'] ?? false,
    );
  }

  // ============================================================================
  // МЕТОД: В JSON
  // ============================================================================
  // Преобразует модель в JSON-объект
  // Используется при сериализации данных для отправки на сервер
  // ============================================================================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'currency': currency,
      'days': days,
      'clientName': clientName,
      'skills': skills,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'category': category,
      'tags': tags,
      'attachments': attachments,
      'urgent': urgent,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        currency,
        days,
        clientName,
        skills,
        isFavorite,
        createdAt,
        category,
        tags,
        attachments,
        urgent,
      ];
}