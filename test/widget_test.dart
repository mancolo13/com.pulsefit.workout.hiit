import 'package:flutter_test/flutter_test.dart';
import 'package:app1/main.dart';

void main() {
  testWidgets('PulseFit renders app correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const PulseFitApp());
    expect(find.byType(PulseFitApp), findsOneWidget);
  });
}
