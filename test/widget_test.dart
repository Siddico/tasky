import 'package:flutter_test/flutter_test.dart';
import 'package:tasky/main.dart';

void main() {
  testWidgets('Tasky login smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskyApp());

    // Verify that login title is displayed.
    expect(find.text('Welcome to Tasky'), findsOneWidget);
    expect(find.text('Login to Application'), findsOneWidget);
  });
}
