import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_event.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_state.dart';
import 'package:miro_manga_chapter_update/bloc/my_mangas_bloc/my_mangas_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/reader_bloc/reader_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/reader_bloc/reader_state.dart';
import 'package:miro_manga_chapter_update/locator.dart';
import 'package:miro_manga_chapter_update/model/chapter_model.dart';

import 'package:miro_manga_chapter_update/view/manga_reader/manga_reader.dart';

class MockAddMangaBloc extends MockBloc<AddMangaEvent, AddMangaState>
    implements AddMangaBloc {}

void main() {
  setUpAll(() {
    setupLocatorTest();
  });

  Chapter chapter = Chapter(
    chapterId: "6210355a-1d80-4efe-aa1b-a13653fd114c",
    title: "First Times",
    number: 18.0,
    volume: "2",
    chapterRead: 0,
    mangadexMangaId: "484f94e7-35c3-4cb5-a068-53d684c1439a",
    pages: 22,
  );

  testWidgets(
    "MangaReader is well instanciated",
    (WidgetTester tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<AddMangaBloc>(
            create: (BuildContext context) => AddMangaBloc(),
          ),
          BlocProvider<MyMangasBloc>(
            create: (BuildContext context) => MyMangasBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => ReaderBloc(),
          )
        ],
        child: MaterialApp(
          home: MangaReader(
            chapter: chapter,
          ),
        ),
      ));
      expect(find.byType(MangaReader), findsOneWidget);
    },
  );

  testWidgets(
    "MangaReader is well instanciated",
    (WidgetTester tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<AddMangaBloc>(
            create: (BuildContext context) => AddMangaBloc(),
          ),
          BlocProvider<MyMangasBloc>(
            create: (BuildContext context) => MyMangasBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => ReaderBloc(),
          )
        ],
        child: MaterialApp(
          home: MangaReader(
            chapter: chapter,
          ),
        ),
      ));
      expect(find.byType(Column), findsOneWidget);
      expect(
          find.descendant(
              of: find.byType(Column),
              matching: find.byType(BlocBuilder<ReaderBloc, ReaderState>)),
          findsOneWidget);

      // expect(
      //     find.descendant(
      //         of: find.descendant(
      //             of: find.byType(Column),
      //             matching: find.byType(BlocBuilder<ReaderBloc, ReaderState>)),
      //         matching: find.byType(InteractiveViewer)),
      //     findsOneWidget);
    },
  );
}
