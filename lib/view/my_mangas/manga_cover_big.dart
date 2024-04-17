import 'package:flutter/material.dart';

class MangaCoverBig extends StatelessWidget {
  const MangaCoverBig({
    super.key,
  });
  // final Manga manga;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'cover',
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/cover_placeholder.jpeg')),
    );
  }
}
