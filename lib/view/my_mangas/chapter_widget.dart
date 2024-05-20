import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/reader_bloc/reader_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/reader_bloc/reader_event.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/my_mangas_bloc/my_mangas_bloc.dart';
import '../../bloc/my_mangas_bloc/my_mangas_event.dart';
import '../../model/chapter_model.dart';
import '../add_manga_view/manga_add_card_text.dart';
import '../manga_reader/manga_reader.dart';

class ChapterWidget extends StatefulWidget {
  const ChapterWidget({
    super.key,
    required this.chapter,
  });
  final Chapter chapter;
  @override
  State<ChapterWidget> createState() => ChapterWidgetState();
}

class ChapterWidgetState extends State<ChapterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: Card(
        color: widget.chapter.chapterRead == 1
            ? Theme.of(context).colorScheme.scrim
            : Theme.of(context).colorScheme.onSecondaryContainer,
        elevation: 2,
        child: Flex(
          textDirection: TextDirection.ltr,
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: _getIconButtons(widget.chapter),
        ),
      ),
    );
  }

  void _openMangaReader(BuildContext context, Chapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MangaReader(
          chapter: chapter,
        ),
      ),
    );
  }

  List<Widget> _getIconButtons(Chapter chapter) {
    List<Widget> widgetList = [];
    //case where a manga does not have an external url and has pages available on the mangadex api
    if (widget.chapter.pages != 0) {
      widgetList = [
        SizedBox(
          width: MediaQuery.of(context).size.width - 120,
          child: MangaAddCardText(
            widgetText:
                "Chapitre ${widget.chapter.number.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
            mangaInfo: widget.chapter.title.isNotEmpty
                ? widget.chapter.title
                : "Pas de titre",
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IconButton(
            key: const Key("mangadex_pages"),
            onPressed: () {
              _openMangaReader(context, widget.chapter);

              context.read<ReaderBloc>().add(
                    GetPagesFromDb(widget.chapter.chapterId),
                  );
            },
            icon: const Icon(Icons.menu_book),
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IconButton(
            onPressed: () {
              context.read<MyMangasBloc>().add(
                    MyMangasChapterReadEvent(
                      chapterId: widget.chapter.chapterId,
                      chapterRead: widget.chapter.chapterRead == 1,
                    ),
                  );
            },
            icon: widget.chapter.chapterRead == 1
                ? const Icon(Icons.verified)
                : const Icon(Icons.verified_outlined),
          ),
        ),
      ];
    }
    //case where a manga does not have pages on mangadex api but has an external url (another website where you can read it)
    else if (widget.chapter.pages == 0 && widget.chapter.externalUrl != null) {
      widgetList = [
        SizedBox(
          width: MediaQuery.of(context).size.width - 120,
          child: MangaAddCardText(
            widgetText:
                "Chapitre ${widget.chapter.number.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
            mangaInfo: widget.chapter.title.isNotEmpty
                ? widget.chapter.title
                : "Pas de titre",
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IconButton(
            key: const Key("external_url"),
            onPressed: () {
              _launchURL(widget.chapter.externalUrl!);
            },
            icon: const Icon(Icons.menu_book),
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IconButton(
            onPressed: () {
              context.read<MyMangasBloc>().add(
                    MyMangasChapterReadEvent(
                      chapterId: widget.chapter.chapterId,
                      chapterRead: widget.chapter.chapterRead == 1,
                    ),
                  );
            },
            icon: widget.chapter.chapterRead == 1
                ? const Icon(Icons.verified)
                : const Icon(Icons.verified_outlined),
          ),
        ),
      ];
    }
    //case where a manga has neither external url nor pages on mangadex api
    else if (widget.chapter.pages == 0 && widget.chapter.externalUrl == null) {
      widgetList = [
        SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: MangaAddCardText(
            widgetText:
                "Chapitre ${widget.chapter.number.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
            mangaInfo: widget.chapter.title.isNotEmpty
                ? widget.chapter.title
                : "Pas de titre",
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IconButton(
            onPressed: () {
              context.read<MyMangasBloc>().add(
                    MyMangasChapterReadEvent(
                      chapterId: widget.chapter.chapterId,
                      chapterRead: widget.chapter.chapterRead == 1,
                    ),
                  );
            },
            icon: widget.chapter.chapterRead == 1
                ? const Icon(Icons.verified)
                : const Icon(Icons.verified_outlined),
          ),
        ),
      ];
    }

    return widgetList;
  }

  _launchURL(String externalUrl) async {
    final Uri url = Uri.parse(externalUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
