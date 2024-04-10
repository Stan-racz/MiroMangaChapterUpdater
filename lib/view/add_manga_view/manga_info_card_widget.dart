import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        child: Column(
          children: [
            MangaAddCardTitle(mangaTitle: manga.titre),
            MangaAddCardText(
              widgetText: "Description",
              mangaInfo: manga.description,
            ),
            MangaAddCardText(
              widgetText: "Année de publication",
              mangaInfo: manga.annee,
            ),
            MangaAddCardText(
              mangaInfo: manga.status,
              widgetText: "Status de Publication",
            ),
            ElevatedButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(10),
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              onPressed: () {
                if (manga.mangadexId.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Recherchez un manga avant de le sauvegarder",
                      backgroundColor: Colors.red[300],
                      textColor: Colors.white,
                      fontSize: 16);
                  return;
                }
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
          ],
        ),
      ),
    );
  }
}
