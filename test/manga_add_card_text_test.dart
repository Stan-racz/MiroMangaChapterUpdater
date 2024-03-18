import 'package:flutter_test/flutter_test.dart';

import 'package:miro_manga_chapter_update/view/manga_add_card_text.dart';

void main() {
  testWidgets(
    "MangaAddCardText has a widget text and some manga infos",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MangaAddCardText(
          widgetText: "description",
          mangaInfo: "The sixth part of the Baki series.",
        ),
      );
      final widgetTextFinder = find.text('description');
      final mangaInfoFinder = find.text('The sixth part of the Baki series.');

      expect(widgetTextFinder, findsOneWidget);
      expect(mangaInfoFinder, findsOneWidget);
    },
  );

  testWidgets(
    "MangaAddCardText has a widget text and no manga info",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MangaAddCardText(
          mangaInfo: "description",
          widgetText: "",
        ),
      );
      final widgetTextFinder = find.text('description');
      final mangaInfoFinder = find.text('');

      expect(widgetTextFinder, findsOneWidget);
      expect(mangaInfoFinder, findsOneWidget);
    },
  );
}
