import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../model/manga_model.dart';

@immutable
abstract class AddMangaEvent extends Equatable {}

class AddMangaToDbEvent extends AddMangaEvent {
  final Manga manga;

  AddMangaToDbEvent(this.manga);

  @override
  List<Object> get props => [manga];
}

class CreateDbEvent extends AddMangaEvent {
  CreateDbEvent();

  @override
  List<Object> get props => [];
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
