// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GenresModel{
  List<Genres> genres = [];


  GenresModel(this.genres);

  GenresModel.fromJson(Map<String, dynamic> json){
    if (json['genres'] != null) {
      //genres = [];
      json['genres'].forEach((v) {
        genres.add(Genres.fromMap(v));
      });
    }
  }
}



class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());


}
