import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view/my_mangas/my_mangas_view.dart';
import 'view/settings/settings_view.dart';

import 'bloc/add_manga_bloc/add_manga_bloc.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'scaffold.dart';
import 'service/manga_db_service.dart';

void main() async {
  setupLocator();
  runApp(const MangaChapterUpdateApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt<MangaDbService>().createTables();
}

class MangaChapterUpdateApp extends StatefulWidget {
  const MangaChapterUpdateApp({super.key});

  @override
  State<MangaChapterUpdateApp> createState() => MangaChapterUpdateAppState();
}

class MangaChapterUpdateAppState extends State<MangaChapterUpdateApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddMangaBloc>(
          create: (BuildContext context) => AddMangaBloc(),
        )
      ],
      child: const MaterialApp(
        home: MyScaffold(),
      ),
    );
  }
}
