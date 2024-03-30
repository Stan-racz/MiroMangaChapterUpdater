import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/my_mangas_bloc/my_mangas_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/my_mangas_bloc/my_mangas_event.dart';

import '../../model/chapter_model.dart';
import '../add_manga_view/manga_add_card_text.dart';

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
      width: double.maxFinite,
      child: Card(
        color: widget.chapter.chapitreLu == 1
            ? const Color(0xffB7F2B6)
            : const Color.fromARGB(255, 255, 255, 255),
        elevation: 2,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: MangaAddCardText(
                  widgetText: "Chapitre ${widget.chapter.number}",
                  mangaInfo: widget.chapter.titre.isNotEmpty
                      ? widget.chapter.titre
                      : "Pas de titre"),
            ),
            IconButton(
              onPressed: () {
                // debugPrint("cc chapter lu ${widget.chapter.chapterId}");
                context.read<MyMangasBloc>().add(MyMangasChapterReadEvent(
                    chapterId: widget.chapter.chapterId,
                    chapterRead: widget.chapter.chapitreLu == 1));
              },
              icon: const Icon(Icons.verified),
            ),
          ],
        ),
      ),
    );
  }
}
