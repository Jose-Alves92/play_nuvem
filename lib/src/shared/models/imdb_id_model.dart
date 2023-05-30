class ImdbIdModel {
  int? id;
  String? imdbId;
  int? tvdbId;
 

  ImdbIdModel(
      {
      this.id,
      this.imdbId,
      });

  ImdbIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] as int : null;
    imdbId = json['imdb_id'] != null ? json['imdb_id'] as String : null;
    tvdbId = json['tvdb_id'] != null ? json['tvdb_id'] as int : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['tvdb_id'] = this.tvdbId;
   
    return data;
  }
}
