import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_manga_bloc/add_manga_bloc.dart';
import 'locator.dart';
import 'view/add_manga.dart';

void main() {
  setupLocator();
  runApp(const MangaChapterUpdateApp());
}

class MangaChapterUpdateApp extends StatelessWidget {
  const MangaChapterUpdateApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return BlocProvider<AddMangaBloc>(
      create: (BuildContext context) => AddMangaBloc(),
      child: const MaterialApp(
        home: AddMangaView(),
      ),
    );
  }
}
