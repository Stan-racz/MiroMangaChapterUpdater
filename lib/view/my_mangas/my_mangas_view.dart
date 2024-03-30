import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
              PopupMenuItem(
                child: const Text("Télécharger les chapitres"),
                onTap: () {
                  context.read<MyMangasBloc>().add(GetAllMangasChaptersEvent());
                },
              ),
              PopupMenuItem(
                child: const Text("Télécharger les covers de manga"),
                onTap: () {
                  context
                      .read<MyMangasBloc>()
                      .add(GetAllMangasCoverLinksEvent());
                },
              )
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
        title: Text(
          "Mes Mangas",
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<MyMangasBloc, MyMangasState>(
                listener: (BuildContext context, MyMangasState state) {
                  // debugPrint(state.toString());
                },
                builder: (BuildContext context, MyMangasState state) {
                  return switch (state) {
                    MyMangasInitial() => GestureDetector(
                        onVerticalDragEnd: (details) {
                          context
                              .read<MyMangasBloc>()
                              .add(GetAllMangasFromDbEvent());
                        },
                        child: const SizedBox(
                          child: Text(
                              "Ajoutez un manga, si cela est fait, scrollez vers le bas"),
                        ),
                      ),
                    MyMangasRetrivedFromDb() => ListView.separated(
                        primary: true,
                        itemCount: state.userMangaList.length,
                        itemBuilder: (context, index) =>
                            MangaCardWidget(manga: state.userMangaList[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      ),
                    MyMangasRetrivedWithChaptersFromDb() =>
                      mangaCardWidgetWithChapters(
                          state.userMangaList, state.userMangaChapterList),
                    MyMangasState() => GestureDetector(
                        onVerticalDragEnd: (details) {
                          context
                              .read<MyMangasBloc>()
                              .add(GetAllMangasFromDbEvent());
                        },
                        child: const SizedBox(),
                      ),
                  };
                },
              ),
            ),
            if (kDebugMode)
              Center(
                child: ElevatedButton(
                  style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(10),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xffE5E5E5),
                    ),
                  ),
                  onPressed: () {
                    context.read<MyMangasBloc>().add(MyMangasTestEvent());
                  },
                  child: const Text(
                    "test",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
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

Future<void> _onRefresh(BuildContext context) async {
  context.read<MyMangasBloc>().add(GetAllMangasFromDbEvent());
}
