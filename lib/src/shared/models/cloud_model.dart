// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CloudModel {
List<Cloud> list = [];
  CloudModel(this.list);


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory CloudModel.fromMap(Map<String, dynamic> map) {
    return CloudModel(
      List<Cloud>.from((map['list'] as List<dynamic>).map<Cloud>((x) => Cloud.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CloudModel.fromJson(String source) => CloudModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

class Cloud {
  String? id;
  final String tipo;
  final String name;
  final Credentials credenciais;
  String? pathBucketMovies;
  String? pathBucketTvShows;
  String? totalCountItems;

  Cloud({this.id, required this.tipo, required this.name, required this.credenciais, this.pathBucketMovies = 'Movies', this.pathBucketTvShows = 'TvShows', this.totalCountItems = '0'});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipo': tipo,
      'name': name,
      'credenciais': credenciais.toMap(),
      'pathBucketMovies': pathBucketMovies,
      'pathBucketTvShows': pathBucketTvShows,
      'totalCountItems': totalCountItems,
    };
  }

  factory Cloud.fromMap(Map<String, dynamic> map) {
    return Cloud(
      id: map['id'],
      tipo: map['tipo'] as String,
      name: map['name'] as String,
      credenciais: Credentials.fromMap(map['credenciais'] as Map<String,dynamic>),
      pathBucketMovies: map['pathBucketMovies'] != null ? map['pathBucketMovies'] as String : null,
      pathBucketTvShows: map['pathBucketTvShows'] != null ? map['pathBucketTvShows'] as String : null,
      totalCountItems: map['totalCountItems'] != null ? map['totalCountItems'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cloud.fromJson(String source) => Cloud.fromMap(json.decode(source) as Map<String, dynamic>);
  
}


class Credentials {
  String endPoint; //'s3.amazonaws.com',
  String accessKey; //'YOUR-ACCESSKEYID',
  String secretKey; //'YOUR-SECRETACCESSKEY',

  Credentials({required this.endPoint, required this.accessKey, required this.secretKey});

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'endPoint': endPoint,
      'accessKey': accessKey,
      'secretKey': secretKey,
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      endPoint: map['endPoint'] as String,
      accessKey: map['accessKey'] as String,
      secretKey: map['secretKey'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Credentials.fromJson(String source) => Credentials.fromMap(json.decode(source) as Map<String, dynamic>);
}
