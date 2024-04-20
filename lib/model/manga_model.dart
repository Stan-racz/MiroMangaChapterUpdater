class MangaApi {
  String? result;
  String? response;
  List<Data>? data;
  int? limit;
  int? offset;
  int? total;

  MangaApi(
      {this.result,
      this.response,
      this.data,
      this.limit,
      this.offset,
      this.total});

  MangaApi.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    response = json['response'];
    if (json['data'] != null) {
      data = <Data>[];
      List<dynamic> jsonDatas = json['data'];
      for (var jsonData in jsonDatas) {
        data!.add(Data.fromJson(jsonData));
      }
    }
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['response'] = response;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    return data;
  }
}

class Data {
  String? id;
  String? type;
  Attributes? attributes;
  List<Relationships>? relationships;

  Data({this.id, this.type, this.attributes, this.relationships});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    if (json['relationships'] != null) {
      relationships = <Relationships>[];
      List<dynamic> jsonDatas = json['relationships'];
      for (var jsonData in jsonDatas) {
        relationships!.add(Relationships.fromJson(jsonData));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    if (relationships != null) {
      data['relationships'] = relationships!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  Title? title;
  List<AltTitles>? altTitles;
  Description? description;
  bool? isLocked;
  Links? links;
  String? originalLanguage;
  String? lastVolume;
  String? lastChapter;
  String? publicationDemographic;
  String? status;
  int? year;
  String? contentRating;
  String? state;
  bool? chapterNumbersResetOnNewVolume;
  String? createdAt;
  String? updatedAt;
  int? version;
  List<String>? availableTranslatedLanguages;
  String? latestUploadedChapter;

  Attributes(
      {this.title,
      this.altTitles,
      this.description,
      this.isLocked,
      this.links,
      this.originalLanguage,
      this.lastVolume,
      this.lastChapter,
      this.publicationDemographic,
      this.status,
      this.year,
      this.contentRating,
      this.state,
      this.chapterNumbersResetOnNewVolume,
      this.createdAt,
      this.updatedAt,
      this.version,
      this.availableTranslatedLanguages,
      this.latestUploadedChapter});

  Attributes.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    if (json['altTitles'] != null) {
      altTitles = <AltTitles>[];
      List<dynamic> jsonDatas = json['altTitles'];
      for (var jsonData in jsonDatas) {
        altTitles!.add(AltTitles.fromJson(jsonData));
      }
    }
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    isLocked = json['isLocked'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    originalLanguage = json['originalLanguage'];
    lastVolume = json['lastVolume'];
    lastChapter = json['lastChapter'];
    publicationDemographic = json['publicationDemographic'];
    status = json['status'];
    year = json['year'];
    contentRating = json['contentRating'];
    state = json['state'];
    chapterNumbersResetOnNewVolume = json['chapterNumbersResetOnNewVolume'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    version = json['version'];
    availableTranslatedLanguages =
        json['availableTranslatedLanguages'].cast<String>();
    latestUploadedChapter = json['latestUploadedChapter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (altTitles != null) {
      data['altTitles'] = altTitles!.map((v) => v.toJson()).toList();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['isLocked'] = isLocked;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    data['originalLanguage'] = originalLanguage;
    data['lastVolume'] = lastVolume;
    data['lastChapter'] = lastChapter;
    data['publicationDemographic'] = publicationDemographic;
    data['status'] = status;
    data['year'] = year;
    data['contentRating'] = contentRating;
    data['state'] = state;
    data['chapterNumbersResetOnNewVolume'] = chapterNumbersResetOnNewVolume;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['version'] = version;
    data['availableTranslatedLanguages'] = availableTranslatedLanguages;
    data['latestUploadedChapter'] = latestUploadedChapter;
    return data;
  }
}

class Title {
  String? en;

  Title({this.en});

  Title.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    return data;
  }
}

class AltTitles {
  String? ja;
  String? en;
  String? ru;
  String? tr;

  AltTitles({this.ja, this.en, this.ru, this.tr});

  AltTitles.fromJson(Map<String, dynamic> json) {
    ja = json['ja'];
    en = json['en'];
    ru = json['ru'];
    tr = json['tr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ja'] = ja;
    data['en'] = en;
    data['ru'] = ru;
    data['tr'] = tr;
    return data;
  }
}

class Description {
  String? en;
  String? ru;
  String? tr;
  String? ptBr;

  Description({this.en, this.ru, this.tr, this.ptBr});

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ru = json['ru'];
    tr = json['tr'];
    ptBr = json['pt-br'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ru'] = ru;
    data['tr'] = tr;
    data['pt-br'] = ptBr;
    return data;
  }
}

class Links {
  String? al;
  String? ap;
  String? kt;
  String? mu;
  String? mal;

  Links({this.al, this.ap, this.kt, this.mu, this.mal});

  Links.fromJson(Map<String, dynamic> json) {
    al = json['al'];
    ap = json['ap'];
    kt = json['kt'];
    mu = json['mu'];
    mal = json['mal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['al'] = al;
    data['ap'] = ap;
    data['kt'] = kt;
    data['mu'] = mu;
    data['mal'] = mal;
    return data;
  }
}

class Relationships {
  String? id;
  String? type;
  String? related;

  Relationships({this.id, this.type, this.related});

  Relationships.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    related = json['related'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['related'] = related;
    return data;
  }
}

class Manga {
  final String mangadexId;
  final String titre;
  final String description;
  final String annee;
  final String status;
  String? coverId;
  String? coverLink;

  Manga({
    required this.mangadexId,
    required this.titre,
    required this.description,
    required this.annee,
    required this.status,
    this.coverId,
    this.coverLink,
  });

  Manga.fromDb(Map<String, dynamic> query)
      : mangadexId = query['mangadex_id'],
        titre = query['title'],
        description = query['description'],
        annee = query['year'],
        status = query['status'],
        coverId = query['cover_id'],
        coverLink = query['cover_link'];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'mangadex_id': mangadexId,
      'title': titre,
      'description': description,
      'year': annee,
      'status': status,
      'cover_id': coverId,
      'cover_link': coverLink,
    };
    return map;
  }
}
