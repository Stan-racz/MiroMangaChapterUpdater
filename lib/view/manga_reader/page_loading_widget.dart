import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageLoadingWidget extends StatelessWidget {
  const PageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Chargement des pages",
          style: GoogleFonts.aBeeZee(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          textDirection: TextDirection.ltr,
        ),
        const SizedBox(
          width: 5,
        ),
        const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
