import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/add_manga_bloc/add_manga_bloc.dart';

import '../../bloc/add_manga_bloc/add_manga_event.dart';
import '../../model/manga_model.dart';
import 'manga_add_card_text.dart';
import 'manga_add_card_title.dart';

class MangaInfoCardWidget extends StatelessWidget {
  final Manga manga;

  const MangaInfoCardWidget({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFBFAFA),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MangaAddCardTitle(mangaTitle: manga.titre),
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
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(10),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.white),
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
      ),
    );
  }
}
