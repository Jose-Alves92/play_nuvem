import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PlaylistModel {
   String id;
   String name;
   String url;
  PlaylistModel({
    required this.id,
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistModel.fromJson(String source) => PlaylistModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
