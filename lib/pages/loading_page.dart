import 'package:flutter/material.dart';
import '../routes.dart';

/// Экран заставки (Loading / Splash Screen).
/// 
/// Выполняет демонстрацию бренда приложения и имитирует первичную инициализацию.
/// Является StatefulWidget, так как запускает асинхронный таймер в жизненном цикле initState().
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // Запуск отложенного перехода через 4 секунды (требование методических указаний).
    // Future.delayed создает одноразовый таймер.
    Future.delayed(const Duration(seconds: 4), () {
      // Проверка mounted обязательна: она гарантирует, что виджет все еще находится
      // в дереве виджетов к моменту срабатывания таймера, предотвращая ошибки setState/Navigator.
      if (!mounted) return;

      // Использование pushReplacementNamed вместо pushNamed удаляет экран заставки
      // из стека навигации (Route Stack). Это не позволяет пользователю вернуться
      // на заставку нажатием системной кнопки «Назад».
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Круглая брендовая иконка приложения
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE9EDFF),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF3157D5),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 52,
                color: Color(0xFF3157D5),
              ),
            ),
            const SizedBox(height: 24),

            // Название приложения
            const Text(
              'Интернет магазин',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF192252),
              ),
            ),
            const SizedBox(height: 8),

            // Подзаголовок
            const Text(
              'Мобильное приложение',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF747B8F),
              ),
            ),
            const SizedBox(height: 32),

            // Индикатор процесса загрузки Material Design
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Color(0xFF3157D5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
