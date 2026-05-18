import 'package:ecommerce_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the welcome experience', (tester) async {
    await tester.pumpWidget(const EcommerceApp());

    expect(
      find.text('Discover products you love and shop with ease.'),
      findsOneWidget,
    );
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('can enter the catalog from login', (tester) async {
    await tester.pumpWidget(const EcommerceApp());

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(
      find.text('Sample account: shopper@shopease.test / shop1234'),
      findsOneWidget,
    );

    await tester.tap(find.text('Login').last);
    await tester.pumpAndSettle();

    expect(find.text('Welcome to ShopEase'), findsOneWidget);
    expect(find.text('Popular Products'), findsOneWidget);
    expect(find.text('All Products'), findsOneWidget);
    expect(find.text('Wireless Headphones'), findsWidgets);
  });

  testWidgets('logo button returns to refreshed home page', (tester) async {
    await tester.pumpWidget(const EcommerceApp());

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Login').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Signed in with sample account.'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('app-logo-home-button')));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to ShopEase'), findsOneWidget);
    expect(find.text('Popular Products'), findsOneWidget);
  });

  testWidgets('search filters products by typed query', (tester) async {
    await tester.pumpWidget(const EcommerceApp());

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Login').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'keyboard');
    await tester.pumpAndSettle();

    expect(find.text('Wireless Keyboard'), findsWidgets);
    expect(find.text('Wireless Headphones'), findsNothing);
  });

  testWidgets('can browse categories and open product details', (tester) async {
    await tester.pumpWidget(const EcommerceApp());

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Login').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.category_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Popular Picks'), findsOneWidget);
    expect(find.text('Audio'), findsOneWidget);

    await tester.tap(find.text('Audio'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Wireless Headphones').first);
    await tester.pumpAndSettle();

    expect(find.text('Details'), findsOneWidget);
    expect(
      find.text('Comfortable everyday headphones with crisp sound.'),
      findsOneWidget,
    );
  });
}
