import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:miro_manga_chapter_update/view/manga_reader/page_loading_widget.dart';

void main() {
  testWidgets(
    "PAgeLoadingWidget is displaying its text and CircularProgressIndicator",
    (WidgetTester tester) async {
      const String widgetText = "Chargement des pages";

      await tester.pumpWidget(
        const PageLoadingWidget(),
      );
      final widgetTextFinder = find.text(widgetText);
      expect(widgetTextFinder, findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
