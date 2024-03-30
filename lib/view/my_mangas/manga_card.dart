import 'package:flutter/material.dart';

import '../../model/chapter_model.dart';
import '../../model/manga_model.dart';
import '../add_manga_view/manga_add_card_text.dart';
import '../add_manga_view/manga_add_card_title.dart';
import 'chapter_widget.dart';

// ignore: must_be_immutable
class MangaCardWidget extends StatefulWidget {
  MangaCardWidget({super.key, required this.manga, this.chapterList});
  final Manga manga;
  List<Chapter>? chapterList;
  @override
  State<MangaCardWidget> createState() => MangaCardState();
}

class MangaCardState extends State<MangaCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
      child: Card(
        color: const Color(0xffE5E5E5),
        elevation: 5,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 75,
                      child: widget.manga.coverLink != null
                          ? Image.network(widget.manga.coverLink!)
                          : Image.asset('assets/cover_placeholder.jpeg')),
                ),
                Expanded(
                  child: MangaAddCardTitle(mangaTitle: widget.manga.titre),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 1,
            ),
            MangaAddCardText(
                widgetText: "Description", mangaInfo: widget.manga.description),
            MangaAddCardText(
                widgetText: "Année de publication",
                mangaInfo: widget.manga.annee),
            MangaAddCardText(
                widgetText: "Status", mangaInfo: widget.manga.status),
            const Divider(
              color: Colors.black,
              height: 10,
            ),
            Column(
              children: widget.chapterList
                      ?.map((chapter) => ChapterWidget(
                            chapter: chapter,
                          ))
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}
