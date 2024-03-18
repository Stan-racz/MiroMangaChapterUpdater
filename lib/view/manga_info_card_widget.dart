import 'package:flutter/material.dart';

import '../model/manga_model.dart';
import 'manga_add_card_text.dart';
import 'manga_add_card_title.dart';

class MangaInfoCardWidget extends StatelessWidget {
  final Manga manga;

  const MangaInfoCardWidget({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffE5E5E5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              // StatusCircleWidget(mangaStatus: manga.status),
              const ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                ),
                onPressed:
                    null, //TODO créer la méthode qui va me permettre d'enregistrer les données du manga récupérées dans la BDD
                child: Text(
                  "Ajouter le Manga",
                  style: TextStyle(
                    color: Colors.black,
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
