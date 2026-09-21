import 'package:flutter_test/flutter_test.dart';

import 'package:qr_scanner_app/main.dart';

void main() {
  testWidgets('login with valid credentials redirects to scanner page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BarcodeScannerApp());

    expect(find.text('Iniciar sesión'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('emailField')), 'admin@qr.com');
    await tester.enterText(find.byKey(const ValueKey('passwordField')), '123456');
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Escáner de código de barras'), findsOneWidget);
  });
}
