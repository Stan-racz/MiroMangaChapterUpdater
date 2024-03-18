import 'package:equatable/equatable.dart';

import '../../model/manga_model.dart';

final class AddMangaState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class AddMangaInitial extends AddMangaState {
  @override
  List<Object> get props => [];
}

final class MangaFoundByTitleState extends AddMangaState {
  final Manga manga;

  MangaFoundByTitleState({required this.manga});

  @override
  List<Object> get props => [];
}

final class MangaLoadingState extends AddMangaState {
  final Manga manga;

  MangaLoadingState({required this.manga});

  @override
  List<Object> get props => [];
}

final class MangaNotFoundState extends AddMangaState {
  // final Manga manga;
  final String error;

  MangaNotFoundState(this.error);

  @override
  List<Object> get props => [];
}
