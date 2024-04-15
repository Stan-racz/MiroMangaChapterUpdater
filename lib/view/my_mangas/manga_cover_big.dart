import 'package:flutter/material.dart';

import '../../model/manga_model.dart';

class MangaCoverBig extends StatelessWidget {
  const MangaCoverBig({
    super.key,
    required this.manga,
  });
  final Manga manga;

  @override
  Widget build(BuildContext context) {
    return Hero(
      // flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => ,
      tag: 'cover-${manga.mangadexId}',
      child: Image.network(manga.coverLink!),
    );
  }
}
