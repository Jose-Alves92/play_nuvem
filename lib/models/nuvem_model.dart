class NuvemModel {
  final String id;
  final String tipo;
  final String name;
  final Credentials credenciais;
  final String? pathBucketMovies;
  final String? pathBucketTvShows;
  String? totalcountitems;

  NuvemModel({required this.id, required this.tipo, required this.name, required this.credenciais, this.pathBucketMovies = 'Movies', this.pathBucketTvShows = 'TvShows', this.totalcountitems});
}


class Credentials {
  final String endPoint; //'s3.amazonaws.com',
  final String accessKey; //'YOUR-ACCESSKEYID',
  final String secretKey; //'YOUR-SECRETACCESSKEY',

  Credentials({required this.endPoint, required this.accessKey, required this.secretKey});
}