import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/model/manga_model.dart';

import 'package:miro_manga_chapter_update/view/add_manga_view/manga_add_card_text.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/manga_add_card_title.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/manga_info_card_widget.dart';

void main() {
  testWidgets(
    "MangaInfoCardWidget is given a manga with all required data",
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

      final MangaInfoCardWidget mangaInfoCardWidget = MangaInfoCardWidget(
        manga: manga,
      );

      await tester.pumpWidget(
        mangaInfoCardWidget,
      );
      //test if the MangaInfoCardWidget is well instanciated
      expect(find.byWidget(mangaInfoCardWidget), findsOneWidget);
      //test if the MangaAddCardText is well instanciated
      expect(find.byType(MangaAddCardText), findsExactly(3));
      //test if the MangaAddCardTitle is well instanciated
      expect(find.byType(MangaAddCardTitle), findsOneWidget);
      //test if the manga data is correctly displayed
      expect(find.text("Baki Rahen"), findsOneWidget);
      expect(find.text("The sixth part of the Baki series"), findsOneWidget);
      expect(find.text("2023"), findsOneWidget);
      expect(find.text("ongoing"), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );

  testWidgets(
    "MangaInfoCardWidget is given a manga with missing description",
    (WidgetTester tester) async {
      final Manga manga = Manga(
        annee: "2023",
        description: "",
        mangadexId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
        status: "ongoing",
        titre: "Baki Rahen",
        coverId: "51a467d5-0706-4aee-9190-d9407338e964",
        coverLink:
            "https://mangadex.org/covers/484f94e7-35c3-4cb5-a068-53d684c1439a/9e78de44-f1bc-42a4-822d-2204e44cadd1.png",
      );

      final MangaInfoCardWidget mangaInfoCardWidget = MangaInfoCardWidget(
        manga: manga,
      );

      await tester.pumpWidget(
        mangaInfoCardWidget,
      );
      //test if the MangaInfoCardWidget is well instanciated
      expect(find.byWidget(mangaInfoCardWidget), findsOneWidget);
      //test if the MangaAddCardText is well instanciated
      expect(find.byType(MangaAddCardText), findsExactly(3));
      //test if the MangaAddCardTitle is well instanciated
      expect(find.byType(MangaAddCardTitle), findsOneWidget);
      //test if the manga data is correctly displayed
      expect(find.text("Baki Rahen"), findsOneWidget);
      expect(find.text(""), findsOneWidget);
      expect(find.text("2023"), findsOneWidget);
      expect(find.text("ongoing"), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );

  testWidgets(
    "MangaInfoCardWidget is given a manga with no data",
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

      final MangaInfoCardWidget mangaInfoCardWidget = MangaInfoCardWidget(
        manga: manga,
      );

      await tester.pumpWidget(
        mangaInfoCardWidget,
      );

      ///test if the MangaInfoCardWidget is well instanciated
      expect(find.byWidget(mangaInfoCardWidget), findsOneWidget);
      //test if the MangaAddCardText is well instanciated
      expect(find.byType(MangaAddCardText), findsExactly(3));
      //test if the MangaAddCardTitle is well instanciated
      expect(find.byType(MangaAddCardTitle), findsOneWidget);
      //test if the manga data is correctly displayed
      expect(find.text(""), findsExactly(4));
      expect(find.byType(ElevatedButton), findsNothing);
    },
  );

  testWidgets("MangaInfoCardWidget is given a manga with missing mangadexId",
      (WidgetTester tester) async {
    final Manga manga = Manga(
      annee: "2023",
      description: "The sixth part of the Baki series",
      mangadexId: "",
      status: "ongoing",
      titre: "Baki Rahen",
      coverId: "51a467d5-0706-4aee-9190-d9407338e964",
      coverLink:
          "https://mangadex.org/covers/484f94e7-35c3-4cb5-a068-53d684c1439a/9e78de44-f1bc-42a4-822d-2204e44cadd1.png",
    );

    final MangaInfoCardWidget mangaInfoCardWidget = MangaInfoCardWidget(
      manga: manga,
    );

    await tester.pumpWidget(
      mangaInfoCardWidget,
    );

    ///test if the MangaInfoCardWidget is well instanciated
    expect(find.byWidget(mangaInfoCardWidget), findsOneWidget);
    //test if the MangaAddCardText is well instanciated
    expect(find.byType(MangaAddCardText), findsExactly(3));
    //test if the MangaAddCardTitle is well instanciated
    expect(find.byType(MangaAddCardTitle), findsOneWidget);
    //test if the manga data is correctly displayed
    expect(find.text("Baki Rahen"), findsOneWidget);
    expect(find.text("The sixth part of the Baki series"), findsOneWidget);
    expect(find.text("2023"), findsOneWidget);
    expect(find.text("ongoing"), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
  });
}
