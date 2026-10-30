import 'package:flutter/material.dart';

/// Модель данных для описания функциональной возможности интернет-магазина.
/// 
/// Используется для передачи данных между экраном каталога (HomePage)
/// и экраном детализации (DetailPage) через аргументы маршрута.
class ShopFeature {
  /// Название пункта (например, "Каталог товаров").
  final String title;

  /// Краткий подзаголовок для карточки в списке.
  final String subtitle;

  /// Развернутое подробное описание для экрана детализации.
  final String description;

  /// Иконка Material Design, отображаемая в карточке и в шапке детализации.
  final IconData icon;

  /// Путь к локальному графическому ресурсу в папке assets/images/.
  final String imagePath;

  const ShopFeature({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.imagePath,
  });
}

/// Статический список основных возможностей интернет-магазина
/// согласно предметной области (Вариант 14 — «Интернет-магазины»).
const List<ShopFeature> shopFeatures = [
  ShopFeature(
    title: 'Каталог товаров',
    subtitle: 'Просмотр доступных товаров интернет-магазина.',
    description:
        'В каталоге представлен широкий ассортимент современных мобильных устройств, умных гаджетов и аксессуаров с удобной фильтрацией по категориям, характеристикам и брендам.',
    icon: Icons.shopping_bag,
    imagePath: 'assets/images/shop_1.jpg',
  ),
  ShopFeature(
    title: 'Поиск товаров',
    subtitle: 'Быстрый поиск нужной продукции.',
    description:
        'Удобный инструмент поиска позволяет быстро находить интересующую продукцию по ключевым словам, категориям и артикулам с мгновенной выдачей результатов.',
    icon: Icons.search,
    imagePath: 'assets/images/shop_2.jpg',
  ),
  ShopFeature(
    title: 'Корзина',
    subtitle: 'Просмотр выбранных товаров и изменение количества.',
    description:
        'Раздел корзины отображает выбранные товары, позволяет гибко управлять количеством позиций, отслеживать промежуточную стоимость и рассчитывать итоговую сумму покупки.',
    icon: Icons.shopping_cart,
    imagePath: 'assets/images/shop_3.jpg',
  ),
  ShopFeature(
    title: 'Оформление заказа',
    subtitle: 'Формирование и подтверждение заказа.',
    description:
        'Простой и понятный процесс оформления покупки с указанием адреса доставки, выбором способа получения и безопасным подтверждением заказа.',
    icon: Icons.check_circle,
    imagePath: 'assets/images/shop_4.jpg',
  ),
];
