import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rapidcare/core/routes/app_router.dart';
import 'package:rapidcare/core/routes/app_routes.dart';
import 'package:rapidcare/core/theme/app_theme.dart';
import 'package:rapidcare/screens/health_education/health_article_details_screen.dart';
import 'package:rapidcare/widgets/dashboard/health_tip_card.dart';
import 'package:rapidcare/widgets/dashboard/health_tips_section.dart';

void main() {
  const tips = [
    (
      'Sleep Better',
      'healthy-sleep-habits',
      'Healthy Sleep Habits',
      'Sleep',
      'Get 7-8 hours of quality sleep for better health.',
      'Quality sleep is essential',
    ),
    (
      'Stay Hydrated',
      'staying-hydrated',
      'Staying Hydrated',
      'Nutrition',
      'Drink at least 8 glasses of water daily.',
      'Water is essential',
    ),
    (
      'Exercise Daily',
      'regular-exercise',
      'Importance of Regular Exercise',
      'Exercise',
      '30 minutes of exercise keeps you fit.',
      'Regular physical activity is one',
    ),
    (
      'Eat Healthy',
      'balanced-nutrition',
      'Understanding Balanced Nutrition',
      'Nutrition',
      'Include fruits and vegetables in your diet.',
      'Balanced nutrition means',
    ),
  ];

  for (final tip in tips) {
    testWidgets('${tip.$1} opens its selected article through AppRouter', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.generateRoute,
          home: const Scaffold(body: HealthTipsSection()),
        ),
      );
      final button = find.descendant(
        of: find.widgetWithText(HealthTipCard, tip.$1),
        matching: find.text('Read More'),
      );
      await tester.ensureVisible(button);
      await tester.pumpAndSettle();
      await tester.tap(button);
      await tester.pumpAndSettle();

      final details = find.byType(HealthArticleDetailsScreen);
      final settings = ModalRoute.of(tester.element(details))!.settings;
      expect(settings.name, AppRoutes.healthArticleDetails);
      expect(settings.arguments, containsPair('id', tip.$2));
      expect(settings.arguments, containsPair('title', tip.$3));
      expect(settings.arguments, containsPair('category', tip.$4));
      expect(settings.arguments, containsPair('content', tip.$5));
      expect(find.text(tip.$3), findsOneWidget);
      expect(find.text(tip.$4), findsOneWidget);
      expect(find.textContaining(tip.$6), findsOneWidget);
      for (final other in tips.where((other) => other.$2 != tip.$2)) {
        expect(find.textContaining(other.$6), findsNothing);
      }
      expect(find.text('Full article unavailable'), findsNothing);
      expect(find.text('Health Education Article'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  Future<void> openArticle(WidgetTester tester, Object? arguments) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.generateRoute,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.healthArticleDetails,
              arguments: arguments,
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'existing Health Education title-only article remains supported',
    (tester) async {
      await openArticle(tester, {
        'title': 'Understanding Blood Pressure',
        'category': 'Heart Health',
      });
      expect(
        find.textContaining('Blood pressure is the force'),
        findsOneWidget,
      );
      expect(find.text('Full article unavailable'), findsNothing);
    },
  );

  testWidgets(
    'unknown ID shows only available content, even with a known title',
    (tester) async {
      await openArticle(tester, {
        'id': 'unpublished-tip',
        'title': 'Healthy Sleep Habits',
        'category': 'Sleep',
        'content': 'The selected tip summary.',
      });
      expect(find.text('The selected tip summary.'), findsOneWidget);
      expect(find.text('Full article unavailable'), findsOneWidget);
      expect(find.textContaining('Quality sleep is essential'), findsNothing);
      expect(find.text('Why It Matters'), findsNothing);
    },
  );

  for (final arguments in [
    null,
    'invalid',
    {'title': 'New tip', 'description': 'Available description.'},
  ]) {
    testWidgets('unavailable article handles arguments: $arguments', (
      tester,
    ) async {
      await openArticle(tester, arguments);
      expect(find.text('Full article unavailable'), findsOneWidget);
      expect(
        find.textContaining('This article provides educational'),
        findsNothing,
      );
      if (arguments is Map) {
        expect(find.text('Available description.'), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
    });
  }
}
