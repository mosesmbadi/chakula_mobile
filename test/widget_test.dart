import 'package:flutter_test/flutter_test.dart';
import 'package:chakula_mobile/main.dart';

void main() {
  testWidgets('App starts test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ChakulaApp());

    // Verify that the location screen is shown.
    expect(find.text('Where are you\neating today?'), findsOneWidget);
  });
}
