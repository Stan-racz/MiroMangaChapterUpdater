import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_bloc.dart';

import '../../bloc/add_manga_bloc/add_manga_event.dart';
import '../../model/manga_model.dart';
import '../my_mangas/manga_cover_big.dart';
import 'manga_add_card_text.dart';
import 'manga_add_card_title.dart';

class MangaInfoCardWidget extends StatelessWidget {
  final Manga manga;

  const MangaInfoCardWidget({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.ltr,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0, 0.0, 8.0),
                  child: Theme.of(context).brightness == Brightness.dark
                      ? SizedBox(
                          width: 75,
                          child: manga.coverLink != null
                              ? GestureDetector(
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      Colors.grey,
                                      BlendMode.darken,
                                    ),
                                    child: Image.network(manga.coverLink!),
                                  ),
                                  onTap: () => _gotoMangaCoverBigPage(
                                    context,
                                    manga,
                                  ),
                                )
                              : GestureDetector(
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      Colors.grey,
                                      BlendMode.darken,
                                    ),
                                    child: Image.asset(
                                        'assets/cover_placeholder.jpeg'),
                                  ),
                                  onTap: () => _gotoMangaCoverBigPage(
                                    context,
                                    manga,
                                  ),
                                ),
                        )
                      : SizedBox(
                          width: 75,
                          child: manga.coverLink != null
                              ? GestureDetector(
                                  child: Image.network(manga.coverLink!),
                                  onTap: () => _gotoMangaCoverBigPage(
                                    context,
                                    manga,
                                  ),
                                )
                              : GestureDetector(
                                  child: Image.asset(
                                      'assets/cover_placeholder.jpeg'),
                                  onTap: () => _gotoMangaCoverBigPage(
                                    context,
                                    manga,
                                  ),
                                ),
                        ),
                ),
                MangaAddCardTitle(mangaTitle: manga.titre),
              ],
            ),
            MangaAddCardText(
              key: const Key('Description'),
              widgetText: "Description",
              mangaInfo: manga.description,
            ),
            MangaAddCardText(
              key: const Key('Année de publication'),
              widgetText: "Année de publication",
              mangaInfo: manga.annee,
            ),
            MangaAddCardText(
              key: const Key('Status de Publication'),
              mangaInfo: manga.status,
              widgetText: "Status de Publication",
            ),
            if (manga.mangadexId.isNotEmpty)
              Directionality(
                textDirection: TextDirection.ltr,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(10),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.tertiary),
                  ),
                  onPressed: () {
                    context.read<AddMangaBloc>().add(
                          AddMangaToDbEvent(manga),
                        );
                  },
                  child: const Text(
                    "Ajouter le Manga",
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

void _gotoMangaCoverBigPage(BuildContext context, Manga manga) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    builder: (BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(manga.titre),
      ),
      body: Center(
        child: MangaCoverBig(
          manga: manga,
        ),
      ),
    ),
  ));
}
