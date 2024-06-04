import 'dart:convert';



class MediaModel {
  int? id;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? title;

  MediaModel({
    this.id,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posterPath': posterPath,
      'mediaType': mediaType,
      'adult': adult,
      'title': title,

    };
  }


    MediaModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    posterPath = map['poster_path'];
    mediaType = map['media_type'];
    adult = map['adult'];
    title = map['title'];
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(String source) => MediaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
