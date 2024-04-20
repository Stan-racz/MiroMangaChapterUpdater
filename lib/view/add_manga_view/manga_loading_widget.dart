import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaLoadingWidget extends StatelessWidget {
  const MangaLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Recherche en cours",
          style: GoogleFonts.aBeeZee(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
          textDirection: TextDirection.ltr,
        ),
        const SizedBox(
          width: 5,
        ),
        const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
