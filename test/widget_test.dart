import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/main.dart';

void main() {
  testWidgets('Full flow smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Splash screen shows title
    expect(find.text('Интернет магазин'), findsOneWidget);

    // Wait for the 4-second splash timer
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Navigated to login page
    expect(find.text('Добро пожаловать!'), findsOneWidget);
    expect(find.text('Войти'), findsOneWidget);
  });
}
