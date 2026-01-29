// ============================================================================
// ФАЙЛ: HOME BLOK - УПРАВЛЕНИЕ СОСТОЯНИЕМ ГЛАВНОЙ СТРАНИЦЫ
// ============================================================================
// ОТВЕЧАЕТ ЗА: Загрузку, фильтрацию, поиск и управление заказами
//              на главной странице приложения
// ============================================================================
// СОБЫТИЯ:
//   - LoadOrders: Загрузить заказы
//   - ToggleFavorite: Переключить избранное
//   - SearchOrders: Поиск заказов
//   - RefreshOrders: Обновить список
//   - FilterOrdersByCategory: Фильтрация по категории
//   - FilterOrdersByBudget: Фильтрация по бюджету
//   - FilterOrdersByDeadline: Фильтрация по срокам
//   - SortOrders: Сортировка
// ============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/order_model.dart';
import 'home_state.dart';
import 'home_event.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // Регистрируем обработчики событий
    
    // Загрузка заказов
    on<LoadOrders>(_onLoadOrders);
    
    // Переключение избранного
    on<ToggleFavorite>(_onToggleFavorite);
    
    // Поиск заказов
    on<SearchOrders>(_onSearchOrders);
    
    // Обновление заказов
    on<RefreshOrders>(_onRefreshOrders);
    
    // Фильтрация по категории
    on<FilterOrdersByCategory>(_onFilterByCategory);
    
    // Фильтрация по бюджету
    on<FilterOrdersByBudget>(_onFilterByBudget);
    
    // Фильтрация по срокам
    on<FilterOrdersByDeadline>(_onFilterByDeadline);
    
    // Сортировка заказов
    on<SortOrders>(_onSortOrders);
  }

  // ============================================================================
  // ОБРАБОТЧИК: ЗАГРУЗКА ЗАКАЗОВ
  // ============================================================================
  // 1. Переводим состояние в "Загрузка"
  // 2. Имитируем задержку сети
  // 3. Создаем моковые данные
  // 4. Переводим в состояние "Загружено"
  // 5. В случае ошибки - в состояние "Ошибка"
  // ============================================================================
  Future<void> _onLoadOrders(LoadOrders event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    
    try {
      // Имитируем задержку сети (в реальном проекте здесь будет API вызов)
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Получаем моковые данные заказов
      final orders = _getMockOrders();
      
      // Создаем состояние с загруженными данными
      emit(HomeLoaded(
        orders: orders,
        activeCount: 142,
        todayCount: 28,
        totalBudget: 4200000,
      ));
    } catch (e) {
      // Обработка ошибки
      emit(HomeError('Ошибка загрузки заказов: $e'));
    }
  }

  // ============================================================================
  // ОБРАБОТЧИК: ПЕРЕКЛЮЧЕНИЕ ИЗБРАННОГО
  // ============================================================================
  // 1. Проверяем, что текущее состояние - "Загружено"
  // 2. Находим заказ по ID
  // 3. Меняем статус избранного
  // 4. Обновляем состояние
  // ============================================================================
  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      
      // Создаем копию списка заказов
      final orders = List<OrderModel>.from(currentState.orders);
      
      // Находим индекс заказа по ID
      final index = orders.indexWhere((order) => order.id == event.orderId);
      
      if (index != -1) {
        // Меняем статус избранного
        orders[index] = orders[index].copyWith(
          isFavorite: !orders[index].isFavorite,
        );
        
        // Обновляем состояние
        emit((currentState as HomeLoaded).copyWith(orders: orders));
        
        // TODO: Сохранить изменения на сервере
      }
    }
  }

  // ============================================================================
  // ОБРАБОТЧИК: ПОИСК ЗАКАЗОВ
  // ============================================================================
  // 1. Фильтрует заказы по запросу
  // 2. Ищет в заголовке, описании и навыках
  // 3. Обновляет состояние с отфильтрованными заказами
  // ============================================================================
  Future<void> _onSearchOrders(SearchOrders event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      
      // Если запрос пустой - показываем все заказы
      if (event.query.isEmpty) {
        emit(currentState);
        return;
      }
      
      // Фильтруем заказы по запросу (регистронезависимо)
      final query = event.query.toLowerCase();
      final filteredOrders = currentState.orders.where((order) {
        return order.title.toLowerCase().contains(query) ||
               order.description.toLowerCase().contains(query) ||
               order.skills.any((skill) => skill.toLowerCase().contains(query));
      }).toList();
      
      // Обновляем состояние с отфильтрованными заказами
      emit((currentState as HomeLoaded).copyWith(orders: filteredOrders));
    }
  }

  // ============================================================================
  // ОБРАБОТЧИК: ОБНОВЛЕНИЕ ЗАКАЗОВ (REFRESH)
  // ============================================================================
  // Аналогичен загрузке, но сохраняет фильтры и сортировку
  // ============================================================================
  Future<void> _onRefreshOrders(RefreshOrders event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      
      emit(HomeLoading());
      
      try {
        await Future.delayed(const Duration(milliseconds: 600));
        
        // Сохраняем фильтры и сортировку, обновляем данные
        final newOrders = _getMockOrders();
        
        // Если были фильтры/поиск - применяем их снова
        if (currentState.orders.length != newOrders.length) {
          // TODO: Применить фильтры к новым данным
        }
        
        emit(currentState.copyWith(orders: newOrders));
      } catch (e) {
        emit(HomeError('Ошибка обновления: $e'));
      }
    }
  }

  // ============================================================================
  // ОБРАБОТЧИК: ФИЛЬТРАЦИЯ ПО КАТЕГОРИИ
  // ============================================================================
  // Фильтрует заказы по выбранной категории
  // ============================================================================
  Future<void> _onFilterByCategory(FilterOrdersByCategory event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      
      final filteredOrders = currentState.orders.where((order) {
        // TODO: Реализовать фильтрацию по категории
        // Временно возвращаем все заказы
        return true;
      }).toList();
      
      emit((currentState as HomeLoaded).copyWith(orders: filteredOrders));
    }
  }

  // ============================================================================
  // ОБРАБОТЧИК: ФИЛЬТРАЦИЯ ПО БЮДЖЕТУ
  // ============================================================================
  // Фильтрует заказы по диапазону бюджета
  // ============================================================================
  Future<void> _onFilterByBudget(FilterOrdersByBudget event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      
      final filteredOrders = currentState.orders.where((order) {
        return order.price >= event.minPrice && order.price <= event.maxPrice;
      }).toList();
      
      emit((currentState as HomeLoaded).copyWith(orders: filteredOrders));
    }
  }

  // ============================================================================
  // ОБРАБОТЧИК: ФИЛЬТРАЦИЯ ПО СРОКАМ
  // ============================================================================
  // Фильтрует заказы по диапазону дней
  // ============================================================================
  Future<void> _onFilterByDeadline(FilterOrdersByDeadline event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      
      final filteredOrders = currentState.orders.where((order) {
        return order.days >= event.minDays && order.days <= event.maxDays;
      }).toList();
      
      emit((currentState as HomeLoaded).copyWith(orders: filteredOrders));
    }
  }

  // ============================================================================
  // ОБРАБОТЧИК: СОРТИРОВКА ЗАКАЗОВ
  // ============================================================================
  // Сортирует заказы по различным критериям
  // ============================================================================
  Future<void> _onSortOrders(SortOrders event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      
      final sortedOrders = List<OrderModel>.from(currentState.orders);
      
      switch (event.sortBy) {
        case 'newest':
          sortedOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case 'oldest':
          sortedOrders.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          break;
        case 'price_low':
          sortedOrders.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_high':
          sortedOrders.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'deadline_short':
          sortedOrders.sort((a, b) => a.days.compareTo(b.days));
          break;
        case 'deadline_long':
          sortedOrders.sort((a, b) => b.days.compareTo(a.days));
          break;
        default:
          // По умолчанию - без сортировки
          break;
      }
      
      emit((currentState as HomeLoaded).copyWith(orders: sortedOrders));
    }
  }

  // ============================================================================
  // МОКОВЫЕ ДАННЫЕ ДЛЯ ДЕМОНСТРАЦИИ
  // ============================================================================
  // Создает тестовые заказы для отображения в интерфейсе
  // ============================================================================
  List<OrderModel> _getMockOrders() {
    return [
      OrderModel(
        id: '1',
        title: 'Разработка Flutter приложения для фрилансеров',
        description: 'Создание мультиплатформенного приложения с минималистичным дизайном и интеграцией платежных систем',
        price: 50000,
        currency: '₽',
        days: 7,
        clientName: 'Иван П.',
        skills: ['Flutter', 'Firebase', 'UI/UX'],
        isFavorite: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        category: 'development',
      ),
      OrderModel(
        id: '2',
        title: 'Дизайн логотипа в темно-зеленых тонах',
        description: 'Минималистичный логотип для IT-стартапа с акцентом на экологичность и технологии',
        price: 25000,
        currency: '₽',
        days: 3,
        clientName: 'Мария С.',
        skills: ['Figma', 'Branding', 'Illustrator'],
        isFavorite: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        category: 'design',
      ),
      OrderModel(
        id: '3',
        title: 'Backend на Node.js для маркетплейса',
        description: 'Разработка REST API с аутентификацией, платежами и системой рейтингов',
        price: 80000,
        currency: '₽',
        days: 14,
        clientName: 'Алексей К.',
        skills: ['Node.js', 'PostgreSQL', 'JWT'],
        isFavorite: false,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        category: 'backend',
      ),
      OrderModel(
        id: '4',
        title: 'Мобильное приложение для доставки еды',
        description: 'Разработка iOS и Android приложения с картой, оплатой и отслеживанием заказов',
        price: 120000,
        currency: '₽',
        days: 21,
        clientName: 'Дмитрий В.',
        skills: ['Flutter', 'Firebase', 'Maps API'],
        isFavorite: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        category: 'development',
      ),
      OrderModel(
        id: '5',
        title: 'Landing page для SaaS продукта',
        description: 'Современный одностраничник с анимациями, формой заявки и интеграцией с почтой',
        price: 15000,
        currency: '₽',
        days: 5,
        clientName: 'Анна Р.',
        skills: ['HTML', 'CSS', 'JavaScript', 'React'],
        isFavorite: false,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        category: 'web',
      ),
    ];
  }
}