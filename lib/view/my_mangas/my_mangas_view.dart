import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/my_mangas_bloc/my_mangas_bloc.dart';
import '../../bloc/my_mangas_bloc/my_mangas_event.dart';
import '../../bloc/my_mangas_bloc/my_mangas_state.dart';
import '../../model/chapter_model.dart';
import '../../model/manga_model.dart';
import 'manga_card.dart';

class MyMangasView extends StatefulWidget {
  const MyMangasView({super.key});
  @override
  State<MyMangasView> createState() => MyMangasViewState();
}

class MyMangasViewState extends State<MyMangasView> {
  @override
  void initState() {
    super.initState();
    context.read<MyMangasBloc>().add(GetAllMangasFromDbEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.filter_list_outlined,
            ),
            itemBuilder: (context) => [
              if (kDebugMode)
                PopupMenuItem(
                  child: const Text("Télécharger les chapitres"),
                  onTap: () {
                    context
                        .read<MyMangasBloc>()
                        .add(GetAllMangasChaptersEvent());
                  },
                ),
              if (kDebugMode)
                PopupMenuItem(
                  child: const Text("Test"),
                  onTap: () {
                    context.read<MyMangasBloc>().add(MyMangasTestEvent());
                  },
                ),
              PopupMenuItem(
                child: const Text("Check les nouveaux chapitres"),
                onTap: () {
                  context
                      .read<MyMangasBloc>()
                      .add(CheckForNewMangaChaptersEvent());
                },
              ),
              if (kDebugMode)
                PopupMenuItem(
                  child: const Text("Télécharger les covers de manga"),
                  onTap: () {
                    context
                        .read<MyMangasBloc>()
                        .add(GetAllMangasCoverLinksEvent());
                  },
                ),
              PopupMenuItem(
                child: const Text("Checker le status de mes mangas"),
                onTap: () {
                  //TODO : MMCU-15
                  Fluttertoast.showToast(
                      msg:
                          "Work in progress! Dispo dans les prochaines releases",
                      backgroundColor: Colors.blue[400],
                      textColor: Colors.white,
                      fontSize: 16);
                },
              ),
            ],
          )
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Colors.orange,
            thickness: 1.5,
          ),
        ),
        title: const Text(
          "Mes Mangas",
        ),
      ),
      body: BlocConsumer<MyMangasBloc, MyMangasState>(
        listener: (BuildContext context, MyMangasState state) {},
        builder: (BuildContext context, MyMangasState state) {
          return switch (state) {
            MyMangasInitial() => GestureDetector(
                onVerticalDragEnd: (details) {
                  context.read<MyMangasBloc>().add(GetAllMangasFromDbEvent());
                },
                child: const SizedBox(),
              ),
            MyMangasRetrivedFromDb() => Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: state.userMangaList.length,
                  itemBuilder: (context, index) =>
                      MangaCardWidget(manga: state.userMangaList[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
              ),
            MyMangasRetrivedWithChaptersFromDb() => mangaCardWidgetWithChapters(
                state.userMangaList, state.userMangaChapterList),
            MyMangasState() => GestureDetector(
                onVerticalDragEnd: (details) {
                  context.read<MyMangasBloc>().add(GetAllMangasFromDbEvent());
                },
                child: const SizedBox(),
              ),
          };
        },
      ),
    );
  }
}

Widget mangaCardWidgetWithChapters(
    List<Manga> userMangas, List<Chapter> userMangasChapters) {
  List<MangaCardWidget> mangaWidgetList = [];

  for (Manga manga in userMangas) {
    List<Chapter> chaptersOfManga = [];
    for (var chapter in userMangasChapters) {
      if (manga.mangadexId == chapter.mangadexMangaId) {
        chaptersOfManga.add(chapter);
      }
    }
    mangaWidgetList.add(
      MangaCardWidget(
        manga: manga,
        chapterList: chaptersOfManga,
      ),
    );
  }

  return ListView.separated(
    itemCount: mangaWidgetList.length,
    itemBuilder: (context, index) => mangaWidgetList[index],
    separatorBuilder: (context, index) => const SizedBox(
      height: 10,
    ),
  );
}
