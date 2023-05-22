class GenresModel{
  List<Genros> genres = [];


  GenresModel(this.genres);

  GenresModel.fromJson(Map<String, dynamic> json){
    if (json['genres'] != null) {
      //genres = [];
      json['genres'].forEach((v) {
        genres.add(Genros.fromJson(v));
      });
    }
  }
}



class Genros {
  int? id;
  String? name;

  Genros({this.id, this.name});

  Genros.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
