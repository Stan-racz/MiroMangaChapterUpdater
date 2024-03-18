import 'package:flutter/material.dart';

class MangaAddCardText extends StatelessWidget {
  const MangaAddCardText(
      {super.key, required this.widgetText, required this.mangaInfo});
  final String widgetText;
  final String mangaInfo;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
          child: Row(
            children: [
              Text(
                widgetText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                " : ",
              ),
              Flexible(
                child: Text(
                  textAlign: TextAlign.start,
                  mangaInfo,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
