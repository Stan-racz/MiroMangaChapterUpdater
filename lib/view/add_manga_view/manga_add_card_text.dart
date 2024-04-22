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
          padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Text(
                widgetText,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                " : ",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Flexible(
                child: Text(
                  textAlign: TextAlign.start,
                  mangaInfo,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
