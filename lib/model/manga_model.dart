class Manga {
  final String mangadexId;
  final String titre;
  final String description;
  final String annee;
  final String status;
  String? coverLink;

  Manga({
    required this.mangadexId,
    required this.titre,
    required this.description,
    required this.annee,
    required this.status,
    this.coverLink,
  });

  Manga.fromJson(Map<String, dynamic> json)
      : mangadexId = json['data'][0]['id'],
        titre = json['data'][0]['attributes']['title']['en'],
        description = json['data'][0]['attributes']['description']['en'],
        annee = json['data'][0]['attributes']['year'].toString(),
        status = json['data'][0]['attributes']['status'];

  Manga.fromDb(Map<String, dynamic> query)
      : mangadexId = query['mangadex_id'],
        titre = query['titre'],
        description = query['description'],
        annee = query['annee'],
        status = query['status'];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'mangadex_id': mangadexId,
      'titre': titre,
      'description': description,
      'annee': annee,
      'status': status,
    };
    return map;
  }
}
