import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/model/manga_model.dart';

import 'package:miro_manga_chapter_update/view/add_manga_view/manga_add_card_title.dart';

void main() {
  testWidgets(
    "MangaAddCardTitle has a title provided",
    (WidgetTester tester) async {
      final Manga manga = Manga(
        annee: "",
        description: "",
        mangadexId: "",
        status: "",
        titre: "Baki",
        coverId: "",
        coverLink: "",
      );

      await tester.pumpWidget(
        MangaAddCardTitle(
          mangaTitle: manga.titre,
        ),
      );

      final mangaTitleFinder = find.text(manga.titre);

      expect(mangaTitleFinder, findsOneWidget);
    },
  );

  testWidgets(
    "MangaAddCardTitle has no title provided",
    (WidgetTester tester) async {
      final Manga manga = Manga(
        annee: "",
        description: "",
        mangadexId: "",
        status: "",
        titre: "",
        coverId: "",
        coverLink: "",
      );

      await tester.pumpWidget(
        MangaAddCardTitle(
          mangaTitle: manga.titre,
        ),
      );

      final mangaTitleFinder = find.text("");

      expect(mangaTitleFinder, findsOneWidget);
    },
  );
}
