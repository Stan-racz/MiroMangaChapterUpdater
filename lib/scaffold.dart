import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/theme_cubit/theme_cubit.dart';
import 'package:miro_manga_chapter_update/utils/color_theme.dart';
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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) => MaterialApp(
        theme: ColorTheme().lightTheme,
        darkTheme: ColorTheme().darkTheme,
        themeMode: mode,
        home: Scaffold(
          body: [
            const MyMangasView(),
            const AddMangaView(),
            const SettingsView(),
          ][_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }
}
