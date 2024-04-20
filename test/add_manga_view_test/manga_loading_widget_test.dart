import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/manga_loading_widget.dart';

void main() {
  testWidgets(
    "MangaLoadingWidget is displaying its text and circular progress indicator",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MangaLoadingWidget(),
      );

      final mangaTitleFinder = find.text("Recherche en cours");
      final circularProgressIndicatorFinder =
          find.byType(CircularProgressIndicator);

      expect(mangaTitleFinder, findsOneWidget);
      expect(circularProgressIndicatorFinder, findsOneWidget);
    },
  );
}
