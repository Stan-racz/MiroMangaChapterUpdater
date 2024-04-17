import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/add_manga.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/manga_info_card_widget.dart';

void main() {
  testWidgets(
    "AddMangaView has no MangaInfoCardWidget children (no manga found in search)",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const AddMangaView(),
      );
      expect(find.byType(MangaInfoCardWidget), findsNothing);
    },
  );
}
