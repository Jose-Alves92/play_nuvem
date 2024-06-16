import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Playlist {
   String? id;
   String name;
   String url;
  Playlist({
    this.id,
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

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'],
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) => Playlist.fromMap(json.decode(source) as Map<String, dynamic>);
}
