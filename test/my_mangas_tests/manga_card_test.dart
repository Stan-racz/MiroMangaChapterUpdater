import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/model/chapter_model.dart';
import 'package:miro_manga_chapter_update/model/manga_model.dart';
import 'package:miro_manga_chapter_update/view/my_mangas/manga_card.dart';

void main() {
  testWidgets(
    "MangaCaard is given a manga with all required manga data and a list of 3 chapters",
    (WidgetTester tester) async {
      final Manga manga = Manga(
        annee: "2023",
        description: "The sixth part of the Baki series",
        mangadexId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
        status: "ongoing",
        titre: "Baki Rahen",
        coverId: "51a467d5-0706-4aee-9190-d9407338e964",
        coverLink:
            "https://mangadex.org/covers/484f94e7-35c3-4cb5-a068-53d684c1439a/9e78de44-f1bc-42a4-822d-2204e44cadd1.png",
      );

      List<Chapter> chapterList = [
        Chapter(
          chapterId: "6210355a-1d80-4efe-aa1b-a13653fd114c",
          title: "First Times",
          number: 18.0,
          volume: "2",
          chapterRead: 0,
          mangadexMangaId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
        ),
        Chapter(
          chapterId: "6210355a-1d80-4efe-aa1b-a13653fd114c",
          title: "A Hanma's Praise",
          number: 17.0,
          volume: "2",
          chapterRead: 0,
          mangadexMangaId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
        ),
        Chapter(
          chapterId: "6210355a-1d80-4efe-aa1b-a13653fd114c",
          title: "Upholding Aesthetics",
          number: 16.0,
          volume: "2",
          chapterRead: 0,
          mangadexMangaId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
        ),
      ];

      final MangaCardWidget mangaCardWidget = MangaCardWidget(
        manga: manga,
        chapterList: chapterList,
      );

      await tester.pumpWidget(
        mangaCardWidget,
      );

      expect(find.byType(MangaCardWidget), findsOneWidget);
    },
  );
}
