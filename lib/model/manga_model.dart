// ignore_for_file: non_constant_identifier_names

class Manga {
  final String mangadex_id;
  final String titre;
  final String description;
  final String annee;
  final String status;

  Manga({
    required this.mangadex_id,
    required this.titre,
    required this.description,
    required this.annee,
    required this.status,
  });

  Manga.fromJson(Map<String, dynamic> json)
      : mangadex_id = json['data'][0]['id'],
        titre = json['data'][0]['attributes']['title']['en'],
        description = json['data'][0]['attributes']['description']['en'],
        annee = json['data'][0]['attributes']['year'].toString(),
        status = json['data'][0]['attributes']['status'];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'mangadex_id': mangadex_id,
      'titre': titre,
      'description': description,
      'annee': annee,
      'status': status,
    };
    return map;
  }
}
