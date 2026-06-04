import 'package:flutter_test/flutter_test.dart';
import 'package:appendidx/main.dart';

void main() {
  testWidgets('AppendiDx app loads splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const AppendiDxApp());
    expect(find.text('AppendiDx'), findsOneWidget);
    expect(find.text('Think Clinically, Diagnose Precisely'), findsOneWidget);
  });
}
