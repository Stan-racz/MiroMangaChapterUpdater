import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:global/global.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/my_mangas_bloc/my_mangas_bloc.dart';
import 'package:miro_manga_chapter_update/bloc/reader_bloc/reader_bloc.dart';

import 'bloc/add_manga_bloc/add_manga_bloc.dart';
import 'bloc/theme_cubit/theme_cubit.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'scaffold.dart';
import 'service/manga_db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await getIt.allReady();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt<MangaDbService>().createTables();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      getIt<FlutterLocalNotificationsPlugin>();

  // Initialize the plugin.
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  //TODO : initialize notifications for iOS in MMCU-18.5
  const DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: darwinInitializationSettings,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const MangaChapterUpdateApp());
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
        ),
        BlocProvider<MyMangasBloc>(
          create: (BuildContext context) => MyMangasBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ReaderBloc(),
        ),
      ],
      child: const MyScaffold(),
    );
  }
}
