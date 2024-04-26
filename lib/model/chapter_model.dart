class Chapter {
  final String chapterId;
  final String title;
  final double number;
  final String volume;
  int? chapterRead = 0;
  final String mangadexMangaId;
  int pages;
  String? externalUrl;

  Chapter({
    required this.chapterId,
    required this.title,
    required this.number,
    required this.volume,
    this.chapterRead,
    required this.mangadexMangaId,
    required this.pages,
    this.externalUrl,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    List<dynamic> relationships = json['relationships'];
    String mangadexMangaId = "";
    for (Map<String, dynamic> relationship in relationships) {
      if (relationship['type'] == "manga") {
        mangadexMangaId = relationship['id'];
        //TODO improve the conversion of api data into models with the correct model from json to dart
      }
    }
    double number = double.parse(json['attributes']['chapter'] ?? 0);

    return Chapter(
      chapterId: json['id'] ?? "",
      title: json['attributes']['title'] ?? "",
      number: number,
      volume: json['attributes']['volume'] ?? "",
      mangadexMangaId: mangadexMangaId,
      pages: json['attributes']['pages'],
      externalUrl: json['attributes']['externalUrl'] ?? "",
    );
  }

  Chapter.fromDb(Map<String, dynamic> query)
      : chapterId = query['chapter_id'],
        title = query['title'],
        number = query['number'],
        volume = query['volume'],
        chapterRead = query['chapter_read'],
        mangadexMangaId = query['mangadex_manga_id'],
        pages = query['pages'],
        externalUrl = query['external_url'];

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': chapterId,
      'title': title,
      'number': number,
      'volume': volume,
      'chapter_read': chapterRead,
      'mangadex_manga_id': mangadexMangaId,
      'pages': pages,
      'external_url': externalUrl,
    };
  }
}
