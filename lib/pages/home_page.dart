import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';
import '../models/shop_feature.dart';
import '../routes.dart';
import 'profile_page.dart';

/// Главный экран приложения (Home Page).
/// 
/// Включает в себя:
/// 1. Основное содержимое каталога (перенесено и доработано из Практической работы №4).
/// 2. Адаптивную компоновку (Responsive Layout): переключение между 1 колонкой (ListView)
///    и 2 колонками (GridView) при ширине экрана > 600 px.
/// 3. Адаптивные отступы между блоками для десктопных и мобильных платформ.
/// 4. Нижнюю панель навигации Material 3 (NavigationBar) для переключения между
///    Каталогом и Профилем через IndexedStack.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Индекс активной вкладки нижней панели NavigationBar:
  // 0 - Каталог (Главная)
  // 1 - Профиль пользователя
  int _selectedIndex = 0;

  // Список локальных изображений для горизонтальной галереи
  final List<String> images = [
    'assets/images/shop_1.jpg',
    'assets/images/shop_2.jpg',
    'assets/images/shop_3.jpg',
    'assets/images/shop_4.jpg',
    'assets/images/shop_5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    // Получение аргументов маршрута, переданных из экрана авторизации или регистрации
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final userName = routeArgs?['name'] ?? 'Юсубов Рашид Хазеинович';
    final userEmail = routeArgs?['email'] ?? 'yusubov.r.k@edu.mirea.ru';

    return Scaffold(
      // Заголовок AppBar динамически меняется в зависимости от активной вкладки
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Интернет магазин' : 'Профиль',
          style: TextStyle(
            fontSize: _selectedIndex == 0 ? 26 : 22,
            fontFamily: _selectedIndex == 0 ? 'GreatVibes' : null,
            fontWeight: _selectedIndex == 0 ? null : FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // IndexedStack сохраняет состояние всех дочерних вкладок в памяти.
      // В отличие от обычной смены экрана, при переключении вкладок состояние скролла
      // каталога и введенные данные в профиле не сбрасываются.
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Вкладка 0: Основной каталог интернет-магазина
          _buildMainCatalog(context),

          // Вкладка 1: Экран профиля пользователя
          // showAppBar: false предотвращает дублирование шапки AppBar
          ProfilePage(
            name: userName,
            email: userEmail,
            showAppBar: false,
            showBackButton: false,
          ),
        ],
      ),

      // Нижняя панель навигации Material 3 (NavigationBar)
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          // Обновление состояния: переключает активный индекс вкладки
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  /// Построение основного экрана каталога с адаптивным дизайном
  Widget _buildMainCatalog(BuildContext context) {
    // Определение платформы (десктоп, веб или мобильная ОС)
    // согласно разделу 4 методических указаний
    final isDesktopOrWeb = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;

    // Адаптивный вертикальный отступ: 24 px для десктопа/веба и 16 px для смартфонов
    final double verticalSpacing = isDesktopOrWeb ? 24.0 : 16.0;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Блок названия предметной области
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Интернет магазин',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),

            SizedBox(height: verticalSpacing),

            // 2. Блок описания предметной области
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Интернет-магазин — программная платформа '
                'для просмотра каталога товаров, поиска продукции, '
                'формирования корзины и оформления заказов.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            SizedBox(height: verticalSpacing),

            // 3. Заголовок горизонтальной фотогалереи
            const Text(
              'Изображения интернет-магазинов',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Горизонтальный ListView.builder со скругленными углами картинок
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 260,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: verticalSpacing + 4),

            // 4. Заголовок блока возможностей
            const Text(
              'Основные возможности',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // 5. Адаптивное отображение списка возможностей (пункт 5 методички):
            // LayoutBuilder предоставляет BoxConstraints родительского контейнера.
            // При constraints.maxWidth > 600 переключаемся на сетку GridView (2 колонки),
            // иначе отображаем компактный вертикальный ListView (1 колонка).
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;

                if (isWide) {
                  // Широкий экран (Desktop / Web / Планшет в альбомной ориентации)
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shopFeatures.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 столбца по заданию
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 95,
                    ),
                    itemBuilder: (context, index) {
                      final item = shopFeatures[index];
                      return _buildFeatureCard(context, item);
                    },
                  );
                } else {
                  // Мобильный экран (Смартфон в портретной ориентации)
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shopFeatures.length,
                    itemBuilder: (context, index) {
                      final item = shopFeatures[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildFeatureCard(context, item),
                      );
                    },
                  );
                }
              },
            ),

            SizedBox(height: verticalSpacing),

            const Divider(thickness: 1),

            SizedBox(height: verticalSpacing),

            // 6. Блок сведений об авторе работы
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Юсубов Р.Х.  ИКБО-63-23',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Построение карточки возможности с обработчиком перехода на экран детализации
  Widget _buildFeatureCard(BuildContext context, ShopFeature item) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: Colors.blue,
          size: 30,
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          item.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 18,
        ),
        // По нажатию на карточку выполняем переход на экран детализации
        // и передаем объект ShopFeature через arguments
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.detail,
            arguments: item,
          );
        },
      ),
    );
  }
}
