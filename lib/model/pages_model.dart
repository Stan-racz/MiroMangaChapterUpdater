class Pages {
  final String chapterId;
  final String hash;
  final String data;
  final String? mangadexMangaId;

  Pages({
    required this.chapterId,
    required this.data,
    required this.hash,
    this.mangadexMangaId,
  });

  factory Pages.fromJson(String chapterId, Map<String, dynamic> json) {
    return Pages(
      chapterId: chapterId,
      hash: json['chapter']['hash'] ?? "",
      data: json['chapter']['data'] ?? "",
    );
  }

  Pages.fromDb(Map<String, dynamic> query)
      : chapterId = query['chapter_id'],
        hash = query['hash'],
        data = query['data'],
        mangadexMangaId = query['mangadex_manga_id'];

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': chapterId,
      'hash': hash,
      'data': data,
      'mangadex_manga_id': mangadexMangaId,
    };
  }
}
