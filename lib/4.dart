import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Интернет-магазины',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const InternetShopPage(),
    );
  }
}

class InternetShopPage extends StatefulWidget {
  const InternetShopPage({super.key});

  @override
  State<InternetShopPage> createState() => _InternetShopPageState();
}

class _InternetShopPageState extends State<InternetShopPage> {
  final List<String> images = [
    'assets/images/shop_1.jpg',
    'assets/images/shop_2.jpg',
    'assets/images/shop_3.jpg',
    'assets/images/shop_4.jpg',
    'assets/images/shop_5.jpg',
  ];

  final List<Map<String, dynamic>> shopItems = [
    {
      'title': 'Каталог товаров',
      'description': 'Просмотр доступных товаров интернет-магазина.',
      'icon': Icons.shopping_bag,
    },
    {
      'title': 'Поиск товаров',
      'description': 'Быстрый поиск нужной продукции.',
      'icon': Icons.search,
    },
    {
      'title': 'Корзина',
      'description': 'Просмотр выбранных товаров и изменение количества.',
      'icon': Icons.shopping_cart,
    },
    {
      'title': 'Оформление заказа',
      'description': 'Формирование и подтверждение заказа.',
      'icon': Icons.check_circle,
    },
  ];

  void showItemSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Выбран пункт: $title'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Интернет-магазины',
          style: TextStyle(
            fontSize: 26,
            fontFamily: 'GreatVibes',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Название ПО
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
                  'Интернет-магазины',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Описание ПО
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

              const SizedBox(height: 20),

              // Заголовок горизонтального списка
              const Text(
                'Изображения интернет-магазинов',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Горизонтальный ListView
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

              const SizedBox(height: 24),

              // Заголовок вертикального списка
              const Text(
                'Основные возможности',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Вертикальный ListView с карточками
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shopItems.length,
                itemBuilder: (context, index) {
                  final item = shopItems[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        item['icon'],
                        color: Colors.blue,
                        size: 30,
                      ),

                      title: Text(
                        item['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        item['description'],
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),

                      onTap: () {
                        showItemSnackBar(item['title']);
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              const Divider(
                thickness: 1,
              ),

              const SizedBox(height: 16),

              // ФИО и группа
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
      ),
    );
  }
}