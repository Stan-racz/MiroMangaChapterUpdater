import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_manga_bloc/add_manga_bloc.dart';
import 'locator.dart';
import 'view/add_manga.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  setupLocator();
  runApp(const MangaChapterUpdateApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
