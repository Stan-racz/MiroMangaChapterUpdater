import 'package:equatable/equatable.dart';

final class ReaderState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class PagesInitial extends ReaderState {
  @override
  List<Object> get props => [];
}

final class ChapterPagesLoading extends ReaderState {
  ChapterPagesLoading();

  @override
  List<Object> get props => [];
}

final class PagesLoaded extends ReaderState {
  PagesLoaded(this.pageList);
  final List<String> pageList;

  @override
  List<Object> get props => [];
}
