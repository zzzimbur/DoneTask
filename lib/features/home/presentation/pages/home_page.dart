import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../widgets/order_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Заказы'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMd,
                vertical: AppConstants.spacingSm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLg),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Поиск заказов...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                      ),
                      style: const TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
              vertical: AppConstants.spacingSm,
            ),
            child: Text(
              '🔥 Горячие заказы',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          OrderCard(
            title: 'Разработка Flutter приложения',
            description: 'Создание мультиплатформенного приложения с минималистичным дизайном',
            price: '50 000 ₽',
            deadline: '7 дней',
            client: 'Иван Петров',
            skills: ['Flutter', 'Firebase', 'UI/UX'],
          ),
          OrderCard(
            title: 'Дизайн логотипа в темно-зеленых тонах',
            description: 'Минималистичный логотип для IT-стартапа',
            price: '25 000 ₽',
            deadline: '3 дня',
            client: 'Мария Сидорова',
            skills: ['Figma', 'Branding', 'Illustrator'],
          ),
          OrderCard(
            title: 'Backend на Node.js',
            description: 'Разработка REST API с аутентификацией и платежами',
            price: '80 000 ₽',
            deadline: '14 дней',
            client: 'Алексей Козлов',
            skills: ['Node.js', 'PostgreSQL', 'JWT'],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}