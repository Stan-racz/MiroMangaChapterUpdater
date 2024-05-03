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
                  child: Text(
                    "Télécharger les chapitres",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () {
                    context
                        .read<MyMangasBloc>()
                        .add(GetAllMangasChaptersEvent());
                  },
                ),
              if (kDebugMode)
                PopupMenuItem(
                  child: Text(
                    "Test",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () {
                    context.read<MyMangasBloc>().add(MyMangasTestEvent());
                  },
                ),
              PopupMenuItem(
                child: Text(
                  "Check les nouveaux chapitres",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () {
                  context
                      .read<MyMangasBloc>()
                      .add(CheckForNewMangaChaptersEvent());
                },
              ),
              if (kDebugMode)
                PopupMenuItem(
                  child: Text(
                    "Télécharger les covers de manga",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () {
                    context
                        .read<MyMangasBloc>()
                        .add(GetAllMangasCoverLinksEvent());
                  },
                ),
              if (kDebugMode)
                PopupMenuItem(
                  child: Text(
                    "Checker le status de mes mangas",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
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
        listener: (BuildContext context, MyMangasState state) {
          if (state is MangadexDown) {
            Fluttertoast.showToast(
              msg: "Erreur : Mangadex Down",
              backgroundColor: Colors.red[300],
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        },
        builder: (BuildContext context, MyMangasState state) {
          return switch (state) {
            MyMangasInitial() => const SizedBox(),
            MyMangasRetrivedFromDb() => ListView.separated(
                shrinkWrap: true,
                primary: true,
                itemCount: state.userMangaList.length,
                itemBuilder: (context, index) =>
                    MangaCardWidget(manga: state.userMangaList[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            MyMangasRetrivedWithChaptersFromDb() => mangaCardWidgetWithChapters(
                state.userMangaList, state.userMangaChapterList),
            MyMangasState() => const SizedBox(),
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
