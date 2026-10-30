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

  int currentImage = 0;

  void nextImage() {
    setState(() {
      currentImage = (currentImage + 1) % images.length;
    });
  }

  void previousImage() {
    setState(() {
      currentImage =
          (currentImage - 1 + images.length) % images.length;
    });
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 260,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: nextImage,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    images[currentImage],
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: previousImage,
                                  icon: const Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                                Text(
                                  '${currentImage + 1} / ${images.length}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: nextImage,
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 260,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Основные возможности:',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text('1. Каталог товаров'),
                          SizedBox(height: 8),
                          Text('2. Поиск товаров'),
                          SizedBox(height: 8),
                          Text('3. Корзина'),
                          SizedBox(height: 8),
                          Text('4. Оформление заказа'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Нажмите на изображение или используйте кнопки '
                      'для смены изображения',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(height: 16),
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
