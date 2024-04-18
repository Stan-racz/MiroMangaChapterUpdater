import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/my_mangas_bloc/my_mangas_bloc.dart';
import '../../bloc/my_mangas_bloc/my_mangas_event.dart';
import '../../model/chapter_model.dart';
import '../../model/manga_model.dart';
import '../add_manga_view/manga_add_card_text.dart';
import '../add_manga_view/manga_add_card_title.dart';
import 'chapter_widget.dart';
import 'manga_cover_big.dart';

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
    return Card(
      color: const Color(0xffE5E5E5),
      elevation: 5,
      child: Column(
        children: [
          SizedBox(
            height: 25,
            child: Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                icon: const Icon(Icons.more_horiz),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      "Supprimer ce manga",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () => context.read<MyMangasBloc>().add(
                        DeleteMangaEvent(
                            mangadexMangaId: widget.manga.mangadexId)),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0, 0.0, 8.0),
                child: SizedBox(
                    width: 75,
                    child: widget.manga.coverLink != null
                        ? GestureDetector(
                            child: Image.network(widget.manga.coverLink!),
                            onTap: () => _gotoMangaCoverBigPage(
                              context,
                              widget.manga,
                            ),
                          )
                        : GestureDetector(
                            child: Image.asset('assets/cover_placeholder.jpeg'),
                            onTap: () => _gotoMangaCoverBigPage(
                              context,
                              widget.manga,
                            ),
                          )),
              ),
              Expanded(
                  child: MangaAddCardTitle(mangaTitle: widget.manga.titre)),
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
    );
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
}
