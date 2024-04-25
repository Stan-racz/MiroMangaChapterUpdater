import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ReaderEvent extends Equatable {}

class GetAllChapterPagesFromApi extends ReaderEvent {
  GetAllChapterPagesFromApi(this.chapterId);
  final String chapterId;

  @override
  List<Object> get props => [];
}

class ChapterPagesLoaded extends ReaderEvent {
  ChapterPagesLoaded(this.pageList);
  final List<Page> pageList;

  @override
  List<Object> get props => [];
}

class GetPagesFromDb extends ReaderEvent {
  GetPagesFromDb(this.chapterId);
  final String chapterId;

  @override
  List<Object> get props => [];
}
