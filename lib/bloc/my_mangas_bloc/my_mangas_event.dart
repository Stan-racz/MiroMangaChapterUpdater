import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class MyMangasEvent extends Equatable {}

class GetAllMangasFromDbEvent extends MyMangasEvent {
  GetAllMangasFromDbEvent();

  @override
  List<Object> get props => [];
}

class GetMangaChaptersFromMangaIdEvent extends MyMangasEvent {
  final String mangadexMangaId;

  GetMangaChaptersFromMangaIdEvent(this.mangadexMangaId);

  @override
  List<Object> get props => [];
}

class GetAllMangasChaptersEvent extends MyMangasEvent {
  GetAllMangasChaptersEvent();

  @override
  List<Object> get props => [];
}

class GetAllMangasCoverLinksEvent extends MyMangasEvent {
  GetAllMangasCoverLinksEvent();

  @override
  List<Object> get props => [];
}

class MyMangasTestEvent extends MyMangasEvent {
  MyMangasTestEvent();

  @override
  List<Object> get props => [];
}
