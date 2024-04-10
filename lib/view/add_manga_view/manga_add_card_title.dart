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
    return Text(
      mangaTitle,
      style: GoogleFonts.aBeeZee(
        fontSize: 32,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
