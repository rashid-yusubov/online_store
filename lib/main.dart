import 'package:flutter/material.dart';
import 'models/shop_feature.dart';
import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/profile_page.dart';
import 'pages/register_page.dart';
import 'routes.dart';

/// Точка входа в приложение (Main Entry Point).
/// Функция `main` запускает корневой виджет `MyApp` с помощью `runApp`.
void main() => runApp(const MyApp());

/// Корневой виджет приложения (Root Widget).
/// 
/// Является `StatelessWidget`, так как конфигурация приложения (тема, маршруты)
/// статична и не требует отслеживания внутреннего изменяемого состояния.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp — базовый виджет Flutter, реализующий Material Design 3.
    // Он настраивает глобальную тему, локализацию, навигатор и таблицу маршрутов.
    return MaterialApp(
      // Отключаем баннер "DEBUG" в правом верхнем углу для аккуратного вида
      debugShowCheckedModeBanner: false,

      // Название приложения (отображается в диспетчере задач ОС)
      title: 'Интернет магазин',

      // Глобальная тема оформления приложения
      theme: ThemeData(
        // Включаем спецификацию Material 3 (актуальный стандарт UI от Google)
        useMaterial3: true,

        // Цветовая схема, автоматически генерируемая из базового синего цвета (seedColor)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3157D5),
          brightness: Brightness.light,
        ),

        // Фоновый цвет для всех экранов приложения
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),

        // Единый стиль верхней панели (AppBar) для всего приложения
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        // Глобальный стиль полей ввода (TextFormField / TextField)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          // Скругление углов рамок полей ввода
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE1E4EC),
            ),
          ),
          // Рамка в обычном (неактивном) состоянии
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE1E4EC),
            ),
          ),
          // Рамка в состоянии фокуса (когда пользователь вводит текст)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF3157D5),
              width: 2,
            ),
          ),
          // Рамка при ошибке валидации
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE05252),
              width: 1.5,
            ),
          ),
          // Рамка при ошибке в активном фокусе
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE05252),
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF6D7487),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFFA7ACB9),
          ),
          prefixIconColor: const Color(0xFF6D7487),
        ),

        // Глобальный стиль основных кнопок (ElevatedButton)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3157D5),
            foregroundColor: Colors.white,
            minimumSize: const Size(
              double.infinity,
              56,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Глобальный стиль текстовых кнопок (TextButton)
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF3157D5),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),

      // Начальный маршрут — экран загрузки (Splash Screen / LoadingPage)
      initialRoute: Routes.loading,

      // Таблица именованных маршрутов (Named Routing) согласно требованиям ПР6:
      // Позволяет перемещаться по приложению через Navigator.pushNamed(context, routeName)
      routes: {
        // Экран загрузки (Splash Screen) с задержкой 4 секунды
        Routes.loading: (_) => const LoadingPage(),

        // Экран авторизации (Login)
        Routes.login: (_) => const LoginPage(),

        // Экран регистрации (Register)
        Routes.register: (_) => const RegisterPage(),

        // Главный экран приложения (Каталог товаров с адаптивной версткой + вкладка профиля)
        Routes.home: (_) => const HomePage(),

        // Экран детального описания товара/преимущества с получением аргументов
        Routes.detail: (context) {
          // Извлекаем переданный объект ShopFeature из настроек маршрута
          final feature =
              ModalRoute.of(context)?.settings.arguments as ShopFeature?;
          return DetailPage(feature: feature);
        },

        // Отдельный экран профиля (если вызывается по именованному маршруту Routes.profile)
        Routes.profile: (context) {
          // Извлекаем переданные параметры пользователя (имя, email)
          final args =
              ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
          return ProfilePage(
            name: args?['name'] ?? 'Юсубов Рашид Хазеинович',
            email: args?['email'] ?? 'yusubov.r.k@edu.mirea.ru',
            showBackButton: true,
          );
        },
      },
    );
  }
}
