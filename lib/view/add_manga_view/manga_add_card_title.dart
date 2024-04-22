import 'package:flutter/material.dart';

class MangaAddCardTitle extends StatelessWidget {
  const MangaAddCardTitle({
    super.key,
    required this.mangaTitle,
  });

  final String mangaTitle;
  @override
  Widget build(BuildContext context) {
    return Text(
      mangaTitle,
      style: Theme.of(context).textTheme.titleLarge,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }
}
