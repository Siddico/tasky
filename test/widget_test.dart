import 'package:flutter_test/flutter_test.dart';
import 'package:tasky/main.dart';

void main() {
  testWidgets('Saudi Landmarks smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Login Page'), findsOneWidget);
    expect(find.text('Saudi Landmarks'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
