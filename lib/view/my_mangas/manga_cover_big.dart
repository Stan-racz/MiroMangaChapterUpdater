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
      tag: 'cover-${manga.mangadexId}',
      child: Image.network(manga.coverLink!),
    );
  }
}
