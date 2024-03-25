import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miro_manga_chapter_update/view/my_mangas/manga_card.dart';

class MyMangasView extends StatefulWidget {
  const MyMangasView({super.key});
  @override
  State<MyMangasView> createState() => MyMangasState();
}

class MyMangasState extends State<MyMangasView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [MangaCardWidget()],
    );
  }
}
