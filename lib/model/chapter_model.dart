class Chapter {
  final String chapterId;
  final String titre;
  final String number;
  final String volume;
  int? chapitreLu = 0;
  final String mangadexMangaId;

  Chapter({
    required this.chapterId,
    required this.titre,
    required this.number,
    required this.volume,
    this.chapitreLu,
    required this.mangadexMangaId,
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
    return Chapter(
      chapterId: json['id'] ?? "",
      titre: json['attributes']['title'] ?? "",
      number: json['attributes']['chapter'] ?? "",
      volume: json['attributes']['volume'] ?? "",
      mangadexMangaId: mangadexMangaId,
    );
  }

  Chapter.fromDb(Map<String, dynamic> query)
      : chapterId = query['chapter_id'],
        titre = query['titre'],
        number = query['number'],
        volume = query['volume'],
        chapitreLu = query['chapitre_lu'],
        mangadexMangaId = query['mangadex_manga_id'];

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': chapterId,
      'titre': titre,
      'number': number,
      'volume': volume,
      'chapitre_lu': chapitreLu,
      'mangadex_manga_id': mangadexMangaId,
    };
  }
}
