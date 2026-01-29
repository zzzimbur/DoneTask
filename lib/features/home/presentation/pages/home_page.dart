// ============================================================================
// ФАЙЛ: HOME PAGE - ГЛАВНАЯ СТРАНИЦА ПРИЛОЖЕНИЯ
// ============================================================================
// ОТВЕЧАЕТ ЗА: Отображение списка заказов, поиск, фильтрацию
//              и взаимодействие с пользователем
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../bloc/home_event.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/stats_bar.dart';
import '../widgets/order_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    
    // Загружаем заказы при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const LoadOrders());
    });
    
    // Слушаем изменения в поле поиска
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
      context.read<HomeBloc>().add(SearchOrders(_searchQuery));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const RefreshOrders());
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.spacingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Поисковая строка
                        SearchBarWidget(
                          hint: 'Поиск заказов...',
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          onClear: _searchQuery.isNotEmpty
                              ? () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                }
                              : null,
                        ),
                        
                        const SizedBox(height: AppConstants.spacingLg),
                        
                        // Заголовок раздела
                        const Text(
                          '🔥 Горячие заказы',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        
                        const SizedBox(height: AppConstants.spacingMd),
                      ],
                    ),
                  ),
                ),
                
                // Список заказов
                if (state is HomeLoading) ...[
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(AppConstants.spacingLg),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ]
                else if (state is HomeError) ...[
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(AppConstants.spacingLg),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: AppColors.error,
                            ),
                            const SizedBox(height: AppConstants.spacingMd),
                            Text(
                              state.message,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
                else if (state is HomeLoaded) ...[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == state.orders.length) {
                          // Статистика в конце списка
                          return StatsBar(
                            activeCount: state.activeCount,
                            todayCount: state.todayCount,
                            totalBudget: state.totalBudget,
                          );
                        }
                        
                        final order = state.orders[index];
                        return OrderCard(order: order);
                      },
                      childCount: state.orders.length + 1, // +1 для статистики
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Заказы'),
      elevation: 0,
      surfaceTintColor: AppColors.surface,
      backgroundColor: AppColors.surface,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // TODO: Открыть уведомления
          },
        ),
        const SizedBox(width: AppConstants.spacingMd),
      ],
    );
  }

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        // TODO: Navigation
      },
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Заказы',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Избранное',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: 'Чат',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}