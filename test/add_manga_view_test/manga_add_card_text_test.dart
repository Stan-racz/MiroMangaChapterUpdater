import 'package:flutter_test/flutter_test.dart';

import 'package:miro_manga_chapter_update/view/add_manga_view/manga_add_card_text.dart';

void main() {
  testWidgets(
    "MangaAddCardText has a widget text and some manga infos",
    (WidgetTester tester) async {
      const String widgetText = "description";
      const String mangaInfo = "The sixth part of the Baki series.";

      await tester.pumpWidget(
        const MangaAddCardText(
          widgetText: widgetText,
          mangaInfo: mangaInfo,
        ),
      );
      final widgetTextFinder = find.text(widgetText);
      final mangaInfoFinder = find.text(mangaInfo);

      expect(widgetTextFinder, findsOneWidget);
      expect(mangaInfoFinder, findsOneWidget);
    },
  );

  testWidgets(
    "MangaAddCardText has a widget text and no manga info",
    (WidgetTester tester) async {
      const String widgetText = "description";
      const String mangaInfo = "";
      await tester.pumpWidget(
        const MangaAddCardText(
          mangaInfo: mangaInfo,
          widgetText: widgetText,
        ),
      );
      final widgetTextFinder = find.text(widgetText);
      final mangaInfoFinder = find.text(mangaInfo);

      expect(widgetTextFinder, findsOneWidget);
      expect(mangaInfoFinder, findsOneWidget);
    },
  );

  testWidgets(
    "MangaAddCardText has no widget text and no manga info",
    (WidgetTester tester) async {
      const String widgetText = '';
      const String mangaInfo = '';
      await tester.pumpWidget(
        const MangaAddCardText(
          mangaInfo: mangaInfo,
          widgetText: widgetText,
        ),
      );

      expect(find.text(""), findsExactly(2));
    },
  );
}
