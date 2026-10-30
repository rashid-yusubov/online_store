import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/main.dart';

void main() {
  testWidgets('Online store list smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Интернет-магазины'), findsWidgets);
    expect(find.text('Основные возможности'), findsOneWidget);
    expect(find.text('Каталог товаров'), findsOneWidget);
  });
}
