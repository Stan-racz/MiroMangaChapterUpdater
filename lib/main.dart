import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:miro_manga_chapter_update/bloc/my_mangas_bloc/my_mangas_bloc.dart';

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

  WidgetsFlutterBinding.ensureInitialized();

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

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
        )
      ],
      child: const MyScaffold(),
    );
  }
}
