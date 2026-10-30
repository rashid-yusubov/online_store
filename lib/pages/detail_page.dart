import 'package:flutter/material.dart';
import '../models/shop_feature.dart';

/// Экран детализации выбранного пункта каталога (Detail Page).
/// 
/// Открывается при нажатии на карточку возможности на главном экране (HomePage).
/// Отображает подробную информацию о выбранном разделе магазина и кнопку возврата.
class DetailPage extends StatelessWidget {
  /// Переданная возможность для отображения (может передаваться напрямую
  /// через конструктор либо через аргументы ModalRoute.of(context)).
  final ShopFeature? feature;

  const DetailPage({
    super.key,
    this.feature,
  });

  @override
  Widget build(BuildContext context) {
    // Извлечение аргумента из маршрута Navigator.pushNamed(context, Routes.detail, arguments: item)
    // Если параметр не передан, используем первый элемент по умолчанию для безопасности.
    final selected = feature ??
        (ModalRoute.of(context)?.settings.arguments as ShopFeature?) ??
        shopFeatures.first;

    return Scaffold(
      // AppBar со стрелкой «Назад» и названием выбранного пункта
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Возврат на предыдущий экран в стеке навигации
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(selected.title),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            // Ограничение ширины для гармоничного отображения на широких экранах
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Блок тематического изображения раздела
                  Container(
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        selected.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Строка с иконкой, названием и кратким подзаголовком
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9EDFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          selected.icon,
                          color: const Color(0xFF3157D5),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selected.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF192252),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selected.subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF747B8F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Divider(),
                  const SizedBox(height: 16),

                  // Заголовок подробного описания
                  const Text(
                    'Подробное описание возможности:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF192252),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Полный текст описания
                  Text(
                    selected.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Color(0xFF4A5164),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Кнопка возврата на главный экран
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Вернуться на главный экран'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
