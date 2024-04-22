import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/model/chapter_model.dart';
import 'package:miro_manga_chapter_update/view/my_mangas/chapter_widget.dart';

void main() {
  testWidgets(
    "Chapter widget is given a chapter with a title and a number double with .0 which should be rounded up ",
    (WidgetTester tester) async {
      Chapter chapter = Chapter(
        chapterId: "6210355a-1d80-4efe-aa1b-a13653fd114c",
        title: "First Times",
        number: 18.0,
        volume: "2",
        chapterRead: 0,
        mangadexMangaId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
      );

      final ChapterWidget chapterWidget = ChapterWidget(chapter: chapter);

      await tester.pumpWidget(
        chapterWidget,
      );

      expect(find.byType(ChapterWidget), findsOneWidget);
      expect(find.text("Chapitre 18"), findsOneWidget);
    },
  );

  testWidgets(
    "Chapter widget is given a chapter with a title and a number double with 18.5 which should display 18.5",
    (WidgetTester tester) async {
      Chapter chapter = Chapter(
        chapterId: "6210355a-1d80-4efe-aa1b-a13653fd114c",
        title: "First Times",
        number: 18.5,
        volume: "2",
        chapterRead: 0,
        mangadexMangaId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
      );

      final ChapterWidget chapterWidget = ChapterWidget(chapter: chapter);

      await tester.pumpWidget(
        chapterWidget,
      );
      expect(find.byType(ChapterWidget), findsOneWidget);
      expect(find.text("Chapitre 18.5"), findsOneWidget);
    },
  );

  testWidgets(
    "Chapter widget is given a chapter with no title",
    (WidgetTester tester) async {
      Chapter chapter = Chapter(
        chapterId: "6210355a-1d80-4efe-aa1b-a13653fd114c",
        title: "",
        number: 18,
        volume: "2",
        chapterRead: 0,
        mangadexMangaId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
      );

      final ChapterWidget chapterWidget = ChapterWidget(chapter: chapter);

      await tester.pumpWidget(
        chapterWidget,
      );
      expect(find.byType(ChapterWidget), findsOneWidget);
      expect(find.text("Chapitre 18"), findsOneWidget);
      expect(find.text("Pas de titre"), findsOneWidget);
    },
  );
}
