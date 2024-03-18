class Manga {
  final String id;
  final String titre;
  final String description;
  final String annee;
  final String status;

  Manga({
    required this.id,
    required this.titre,
    required this.description,
    required this.annee,
    required this.status,
  });

  Manga.fromJson(Map<String, dynamic> json)
      : id = json['data'][0]['id'],
        titre = json['data'][0]['attributes']['title']['en'],
        description = json['data'][0]['attributes']['description']['en'],
        annee = json['data'][0]['attributes']['year'].toString(),
        status = json['data'][0]['attributes']['status'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'annee': annee,
      'status': status,
    };
  }
}


// class Manga {
//   String? result;
//   String? response;
//   List<Data>? data;
//   int? limit;
//   int? offset;
//   int? total;

//   Manga(
//       {this.result,
//       this.response,
//       this.data,
//       this.limit,
//       this.offset,
//       this.total,
//       required String id});

//   Manga.fromJson(Map<String, dynamic> json) {
//     result = json['result'];
//     response = json['response'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     limit = json['limit'];
//     offset = json['offset'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['result'] = result;
//     data['response'] = response;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['limit'] = limit;
//     data['offset'] = offset;
//     data['total'] = total;
//     return data;
//   }
// }

// class Data {
//   String? id;
//   String? type;
//   Attributes? attributes;
//   List<Relationships>? relationships;

//   Data({this.id, this.type, this.attributes, this.relationships});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     attributes = json['attributes'] != null
//         ? Attributes.fromJson(json['attributes'])
//         : null;
//     if (json['relationships'] != null) {
//       relationships = <Relationships>[];
//       json['relationships'].forEach((v) {
//         relationships!.add(Relationships.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type'] = type;
//     if (attributes != null) {
//       data['attributes'] = attributes!.toJson();
//     }
//     if (relationships != null) {
//       data['relationships'] = relationships!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Attributes {
//   Title? title;
//   List<AltTitles>? altTitles;
//   Description? description;
//   bool? isLocked;
//   Links? links;
//   String? originalLanguage;
//   String? lastVolume;
//   String? lastChapter;
//   String? publicationDemographic;
//   String? status;
//   int? year;
//   String? contentRating;
//   List<Tags>? tags;
//   String? state;
//   bool? chapterNumbersResetOnNewVolume;
//   String? createdAt;
//   String? updatedAt;
//   int? version;
//   List<String>? availableTranslatedLanguages;
//   String? latestUploadedChapter;

//   Attributes(
//       {this.title,
//       this.altTitles,
//       this.description,
//       this.isLocked,
//       this.links,
//       this.originalLanguage,
//       this.lastVolume,
//       this.lastChapter,
//       this.publicationDemographic,
//       this.status,
//       this.year,
//       this.contentRating,
//       this.tags,
//       this.state,
//       this.chapterNumbersResetOnNewVolume,
//       this.createdAt,
//       this.updatedAt,
//       this.version,
//       this.availableTranslatedLanguages,
//       this.latestUploadedChapter});

//   Attributes.fromJson(Map<String, dynamic> json) {
//     title = json['title'] != null ? Title.fromJson(json['title']) : null;
//     if (json['altTitles'] != null) {
//       altTitles = <AltTitles>[];
//       json['altTitles'].forEach((v) {
//         altTitles!.add(AltTitles.fromJson(v));
//       });
//     }
//     description = json['description'] != null
//         ? Description.fromJson(json['description'])
//         : null;
//     isLocked = json['isLocked'];
//     links = json['links'] != null ? Links.fromJson(json['links']) : null;
//     originalLanguage = json['originalLanguage'];
//     lastVolume = json['lastVolume'];
//     lastChapter = json['lastChapter'];
//     publicationDemographic = json['publicationDemographic'];
//     status = json['status'];
//     year = json['year'];
//     contentRating = json['contentRating'];
//     // if (json['tags'] != null) {
//     //   tags = <Tags>[];
//     //   json['tags'].forEach((v) {
//     //     tags!.add(Tags.fromJson(v));
//     //   });
//     // }
//     state = json['state'];
//     chapterNumbersResetOnNewVolume = json['chapterNumbersResetOnNewVolume'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     version = json['version'];
//     availableTranslatedLanguages =
//         json['availableTranslatedLanguages'].cast<String>();
//     latestUploadedChapter = json['latestUploadedChapter'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (title != null) {
//       data['title'] = title!.toJson();
//     }
//     if (altTitles != null) {
//       data['altTitles'] = altTitles!.map((v) => v.toJson()).toList();
//     }
//     if (description != null) {
//       data['description'] = description!.toJson();
//     }
//     data['isLocked'] = isLocked;
//     if (links != null) {
//       data['links'] = links!.toJson();
//     }
//     data['originalLanguage'] = originalLanguage;
//     data['lastVolume'] = lastVolume;
//     data['lastChapter'] = lastChapter;
//     data['publicationDemographic'] = publicationDemographic;
//     data['status'] = status;
//     data['year'] = year;
//     data['contentRating'] = contentRating;
//     // if (tags != null) {
//     //   data['tags'] = tags!.map((v) => v.toJson()).toList();
//     // }
//     data['state'] = state;
//     data['chapterNumbersResetOnNewVolume'] = chapterNumbersResetOnNewVolume;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['version'] = version;
//     data['availableTranslatedLanguages'] = availableTranslatedLanguages;
//     data['latestUploadedChapter'] = latestUploadedChapter;
//     return data;
//   }
// }

// class Title {
//   String? en;

//   Title({this.en});

//   Title.fromJson(Map<String, dynamic> json) {
//     en = json['en'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['en'] = en;
//     return data;
//   }
// }

// class AltTitles {
//   String? ja;
//   String? en;
//   String? ru;
//   String? tr;

//   AltTitles({this.ja, this.en, this.ru, this.tr});

//   AltTitles.fromJson(Map<String, dynamic> json) {
//     ja = json['ja'];
//     en = json['en'];
//     ru = json['ru'];
//     tr = json['tr'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ja'] = ja;
//     data['en'] = en;
//     data['ru'] = ru;
//     data['tr'] = tr;
//     return data;
//   }
// }

// class Description {
//   String? en;
//   String? ru;
//   String? tr;
//   String? ptBr;

//   Description({this.en, this.ru, this.tr, this.ptBr});

//   Description.fromJson(Map<String, dynamic> json) {
//     en = json['en'];
//     ru = json['ru'];
//     tr = json['tr'];
//     ptBr = json['pt-br'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['en'] = en;
//     data['ru'] = ru;
//     data['tr'] = tr;
//     data['pt-br'] = ptBr;
//     return data;
//   }
// }

// class Links {
//   String? al;
//   String? ap;
//   String? kt;
//   String? mu;
//   String? mal;

//   Links({this.al, this.ap, this.kt, this.mu, this.mal});

//   Links.fromJson(Map<String, dynamic> json) {
//     al = json['al'];
//     ap = json['ap'];
//     kt = json['kt'];
//     mu = json['mu'];
//     mal = json['mal'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['al'] = al;
//     data['ap'] = ap;
//     data['kt'] = kt;
//     data['mu'] = mu;
//     data['mal'] = mal;
//     return data;
//   }
// }

// class Tags {
//   String? id;
//   String? type;
//   Attributes? attributes;
//   List<void>? relationships;

//   Tags({this.id, this.type, this.attributes, this.relationships});

//   // Tags.fromJson(Map<String, dynamic> json) {
//   //   id = json['id'];
//   //   type = json['type'];
//   //   attributes = json['attributes'] != null
//   //       ? Attributes.fromJson(json['attributes'])
//   //       : null;
//   //   if (json['relationships'] != null) {
//   //     relationships = <Null>[];
//   //     json['relationships'].forEach((v) {
//   //       relationships!.add(Null.fromJson(v));
//   //     });
//   //   }
//   // }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = <String, dynamic>{};
//   //   data['id'] = id;
//   //   data['type'] = type;
//   //   if (attributes != null) {
//   //     data['attributes'] = attributes!.toJson();
//   //   }
//   //   if (relationships != null) {
//   //     data['relationships'] = relationships!.map((v) => v.toJson()).toList();
//   //   }
//   //   return data;
//   // }
// }

// // class Attributes {
// // 	Title? name;
// // 	Description? description;
// // 	String? group;
// // 	int? version;

// // 	Attributes({this.name, this.description, this.group, this.version});

// // 	Attributes.fromJson(Map<String, dynamic> json) {
// // 		name = json['name'] != null ? Title.fromJson(json['name']) : null;
// // 		description = json['description'] != null ? Description.fromJson(json['description']) : null;
// // 		group = json['group'];
// // 		version = json['version'];
// // 	}

// // 	Map<String, dynamic> toJson() {
// // 		final Map<String, dynamic> data = <String, dynamic>{};
// // 		if (name != null) {
// //       data['name'] = name!.toJson();
// //     }
// // 		if (description != null) {
// //       data['description'] = description!.toJson();
// //     }
// // 		data['group'] = group;
// // 		data['version'] = version;
// // 		return data;
// // 	}
// // }

// // class Description {

// // 	Description({});

// // 	Description.fromJson(Map<String, dynamic> json) {
// // 	}

// // 	Map<String, dynamic> toJson() {
// // 		final Map<String, dynamic> data = <String, dynamic>{};
// // 		return data;
// // 	}
// // }

// class Relationships {
//   String? id;
//   String? type;
//   String? related;

//   Relationships({this.id, this.type, this.related});

//   Relationships.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     related = json['related'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type'] = type;
//     data['related'] = related;
//     return data;
//   }
// }

// // class Attributes {
// // 	Title? name;
// // 	Description? description;
// // 	String? group;
// // 	int? version;

// // 	Attributes({this.name, this.description, this.group, this.version});

// // 	Attributes.fromJson(Map<String, dynamic> json) {
// // 		name = json['name'] != null ? Title.fromJson(json['name']) : null;
// // 		description = json['description'] != null ? Description.fromJson(json['description']) : null;
// // 		group = json['group'];
// // 		version = json['version'];
// // 	}

// // 	Map<String, dynamic> toJson() {
// // 		final Map<String, dynamic> data = <String, dynamic>{};
// // 		if (name != null) {
// //       data['name'] = name!.toJson();
// //     }
// // 		if (description != null) {
// //       data['description'] = description!.toJson();
// //     }
// // 		data['group'] = group;
// // 		data['version'] = version;
// // 		return data;
// // 	}
// // }


