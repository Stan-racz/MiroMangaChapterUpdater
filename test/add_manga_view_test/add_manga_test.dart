import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_event.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_state.dart';
import 'package:miro_manga_chapter_update/bloc/my_mangas_bloc/my_mangas_bloc.dart';
import 'package:miro_manga_chapter_update/locator.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/add_manga.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/manga_info_card_widget.dart';

class MockAddMangaBloc extends MockBloc<AddMangaEvent, AddMangaState>
    implements AddMangaBloc {}

void main() {
  setUpAll(() {
    setupLocatorTest();
  });

  testWidgets(
    "AddMangaView has no MangaInfoCardWidget children (no manga found in search)",
    (WidgetTester tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<AddMangaBloc>(
            create: (BuildContext context) => AddMangaBloc(),
          ),
          BlocProvider<MyMangasBloc>(
            create: (BuildContext context) => MyMangasBloc(),
          )
        ],
        child: const MaterialApp(
          home: AddMangaView(),
        ),
      ));
      expect(find.byType(MangaInfoCardWidget), findsNothing);
    },
  );

  testWidgets(
    "AddMangaView is well instanciated",
    (WidgetTester tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<AddMangaBloc>(
            create: (BuildContext context) => AddMangaBloc(),
          ),
          BlocProvider<MyMangasBloc>(
            create: (BuildContext context) => MyMangasBloc(),
          )
        ],
        child: const MaterialApp(
          home: AddMangaView(),
        ),
      ));
      expect(find.byType(AddMangaView), findsOneWidget);
    },
  );
}
