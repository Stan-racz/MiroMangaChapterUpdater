import 'package:go_router/go_router.dart';
import 'view/add_manga_view/add_manga.dart';
import 'view/my_mangas/my_mangas_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'Mes Mangas',
      builder: (context, state) => const MyMangasView(),
    ),
    GoRoute(
      path: '/rechercher/',
      name: 'Rechercher',
      builder: (context, state) => const AddMangaView(),
    ),
  ],
);
