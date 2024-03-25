import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaAddCardTitle extends StatelessWidget {
  const MangaAddCardTitle({
    super.key,
    required this.mangaTitle,
  });

  final String mangaTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
      child: SizedBox(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "$mangaTitle ",
            style: GoogleFonts.shojumaru(fontSize: 32),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
