import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miro_manga_chapter_update/view/add_manga_view/add_manga.dart';
import 'package:miro_manga_chapter_update/view/my_mangas/my_mangas_view.dart';
import 'package:miro_manga_chapter_update/view/settings/settings_view.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});
  @override
  State<MyScaffold> createState() => MyScaffoldState();
}

class MyScaffoldState extends State<MyScaffold> {
  int _currentIndex = 0;
  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajoutez votre manga',
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.grey[300],
            height: 1,
          ),
          [
            const MyMangasView(),
            const AddMangaView(),
            const SettingsView(),
          ][_currentIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        currentIndex: _currentIndex,
        onTap: (index) => setCurrentIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Mes Mangas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Rechercher",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Paramètres",
          )
        ],
      ),
    );
  }
}
