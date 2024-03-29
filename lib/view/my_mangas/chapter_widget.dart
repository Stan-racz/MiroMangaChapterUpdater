import 'package:flutter/material.dart';

import '../add_manga_view/manga_add_card_text.dart';

class ChapterWidget extends StatefulWidget {
  const ChapterWidget(
      {super.key,
      required this.chapterNumber,
      required this.chapterTitle,
      required this.chapterRead});
  final String chapterNumber;
  final String chapterTitle;
  final int chapterRead;
  @override
  State<ChapterWidget> createState() => ChapterWidgetState();
}

class ChapterWidgetState extends State<ChapterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        color: widget.chapterRead == 1
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
                  widgetText: "Chapitre ${widget.chapterNumber.toString()}",
                  mangaInfo: widget.chapterTitle.isNotEmpty
                      ? widget.chapterTitle
                      : "Pas de titre"),
            ),
            IconButton(
              onPressed: () {
                debugPrint("cc chapter lu");
              },
              icon: const Icon(Icons.check_box),
            ),
          ],
        ),
      ),
    );
  }
}
