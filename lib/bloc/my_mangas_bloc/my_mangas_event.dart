import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../model/manga_model.dart';

@immutable
abstract class AddMangaEvent extends Equatable {}

class GetAllMangasFromDbEvent extends AddMangaEvent {
  final Manga manga;

  GetAllMangasFromDbEvent(this.manga);

  @override
  List<Object> get props => [manga];
}

class SearchMangaFromTitleEvent extends AddMangaEvent {
  final String title;

  SearchMangaFromTitleEvent(this.title);

  @override
  List<Object> get props => [];
}

class TestEvent extends AddMangaEvent {
  TestEvent();

  @override
  List<Object> get props => [];
}
