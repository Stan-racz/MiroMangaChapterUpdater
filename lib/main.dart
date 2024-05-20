import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

import 'bloc/add_manga_bloc/add_manga_bloc.dart';
import 'bloc/my_mangas_bloc/my_mangas_bloc.dart';
import 'bloc/reader_bloc/reader_bloc.dart';
import 'bloc/theme_cubit/theme_cubit.dart';
import 'scaffold.dart';
import 'service/manga_db_service.dart';
import 'utils/color_theme.dart';
import 'utils/firebase_options.dart';
import 'utils/locator.dart' as loc;
import 'utils/worker_class.dart';

void main() async {
  final GetIt getIt = GetIt.I;
  WidgetsFlutterBinding.ensureInitialized();

  await loc.setupLocator();
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

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == "read_chapter") {
            chapterReadingStream.add(notificationResponse.payload);
          }
          if (notificationResponse.actionId == "chapter_already_read") {
            updateChapterReadStream.add(notificationResponse.payload);
          }
          break;
      }
    },
  );
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();

  Workmanager().initialize(
    callbackDispatcher,
  );
  Workmanager().registerPeriodicTask(
    "check_new_chapters",
    "check_chapter_task",
    initialDelay: Duration.zero,
    frequency: const Duration(hours: 6),
  );

  runApp(const MangaChapterUpdateApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (task, inputData) async {
      try {
        return await ChapterCheckBackGroundWorker.checkNewChapters();
      } catch (err) {
        debugPrint("error : $err");
        throw Exception(err);
      }
    },
  );
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
          create: (BuildContext context) => loc.getIt<AddMangaBloc>(),
        ),
        BlocProvider<MyMangasBloc>(
          create: (BuildContext context) => loc.getIt<MyMangasBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) => loc.getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => loc.getIt<ReaderBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          theme: ColorTheme().lightTheme,
          darkTheme: ColorTheme().darkTheme,
          themeMode: mode,
          home: const MyScaffold(),
        ),
      ),
    );
  }
}
