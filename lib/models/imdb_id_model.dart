class ImdbIdModel {
  int? id;
  String? imdbId;
  String? freebaseMid;
  String? freebaseId;
  int? tvdbId;
  String? tvrageId;
  String? wikidataId;
  String? facebookId;
  String? instagramId;
  String? twitterId;

  ImdbIdModel(
      {this.id,
      this.imdbId,
      this.freebaseMid,
      this.freebaseId,
      this.tvdbId,
      this.tvrageId,
      this.wikidataId,
      this.facebookId,
      this.instagramId,
      this.twitterId});

  ImdbIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imdbId = json['imdb_id'];
    freebaseMid = json['freebase_mid'];
    freebaseId = json['freebase_id'];
    tvdbId = json['tvdb_id'];
    tvrageId = json['tvrage_id'];
    wikidataId = json['wikidata_id'];
    facebookId = json['facebook_id'];
    instagramId = json['instagram_id'];
    twitterId = json['twitter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['freebase_mid'] = this.freebaseMid;
    data['freebase_id'] = this.freebaseId;
    data['tvdb_id'] = this.tvdbId;
    data['tvrage_id'] = this.tvrageId;
    data['wikidata_id'] = this.wikidataId;
    data['facebook_id'] = this.facebookId;
    data['instagram_id'] = this.instagramId;
    data['twitter_id'] = this.twitterId;
    return data;
  }
}
