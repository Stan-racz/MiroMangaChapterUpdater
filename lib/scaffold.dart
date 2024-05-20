import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/my_mangas_bloc/my_mangas_bloc.dart';
import 'bloc/my_mangas_bloc/my_mangas_event.dart';
import 'bloc/reader_bloc/reader_bloc.dart';
import 'bloc/reader_bloc/reader_event.dart';
import 'model/chapter_model.dart';
import 'service/manga_db_service.dart';
import 'utils/locator.dart' as loc;
import 'view/add_manga_view/add_manga.dart';
import 'view/manga_reader/manga_reader.dart';
import 'view/my_mangas/my_mangas_view.dart';
import 'view/settings/settings_view.dart';

final StreamController<String?> chapterReadingStream =
    StreamController<String?>.broadcast();

final StreamController<String?> updateChapterReadStream =
    StreamController<String?>.broadcast();

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});
  @override
  State<MyScaffold> createState() => MyScaffoldState();
}

class MyScaffoldState extends State<MyScaffold> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
  }

  void _configureSelectNotificationSubject() {
    chapterReadingStream.stream.listen(
      (String? chapterId) async {
        if (chapterId != null) {
          Chapter chapter = await loc
              .getIt<MangaDbService>()
              .getChapterFromChapterId(chapterId);

          if (mounted) {
            context.read<ReaderBloc>().add(
                  GetPagesFromDb(chapter.chapterId),
                );
          }

          if (mounted && chapter.pages != 0) {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => MangaReader(
                  chapter: chapter,
                ),
              ),
            );
          } else if (mounted && chapter.externalUrl != null) {
            if (chapter.externalUrl!.isNotEmpty) {
              final Uri url = Uri.parse(chapter.externalUrl!);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            }
          }
        }
      },
    );

    updateChapterReadStream.stream.listen(
      (String? chapterId) async {
        if (chapterId != null) {
          Chapter chapter = await loc
              .getIt<MangaDbService>()
              .getChapterFromChapterId(chapterId);

          if (mounted) {
            context.read<MyMangasBloc>().add(
                  MyMangasChapterReadEvent(
                    chapterId: chapter.chapterId,
                    chapterRead: chapter.chapterRead == 1,
                  ),
                );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    chapterReadingStream.close();
  }

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const MyMangasView(),
        const AddMangaView(),
        const SettingsView(),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setCurrentIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Mes Mangas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Rechercher",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Paramètres",
          )
        ],
      ),
    );
  }
}
