import 'package:flutter_test/flutter_test.dart';
import 'package:online_store/main.dart';

void main() {
  testWidgets('Auth screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Добро пожаловать!'), findsOneWidget);
    expect(find.text('Войти'), findsOneWidget);
  });
}
