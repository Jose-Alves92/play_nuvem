// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Media {
  int? id;
  String? title;
  String? mediaType;
  bool? adult;
  
  Media({
    this.id,
    this.title,
   
    this.mediaType,
    this.adult,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'media_type': mediaType,
      'adult': adult,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['id'],
      title: map['title'] ?? map['name'],
      mediaType: map['media_type'] ?? '',
      adult: map['adult'],
    );
  }


  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source) as Map<String, dynamic>);
}
