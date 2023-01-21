import 'package:minio/models.dart';
import 'package:play_nuvem/models/movie_detail_model.dart';
import 'package:play_nuvem/repositories/nuvem_repository.dart';
import 'package:minio/minio.dart';
import 'package:play_nuvem/services/tmdb/http_service.dart';
import 'package:play_nuvem/services/tmdb/dio_service_imp.dart';
import 'package:play_nuvem/utils/api_tmdb_utils.dart';

class NuvemRepositoryImp implements NuvemRepository {
  final HttpService _tmdbService = DioServiceImp();
  @override
  Future<ListObjectsResult> getListReproduction({required String endPoint, required String accessKey, required String secretKey, required String titleSearch, required String PathBucket}) async {
    // TODO: implement getListReproduction
    final minio = Minio(
      endPoint: endPoint,
      accessKey: accessKey,
      secretKey: secretKey,
    );

    final response = await minio.listAllObjects(PathBucket, prefix: titleSearch);
    return response;
    
  }
  
  @override
  Future<String> getUrl({required String endPoint, required String accessKey, required String secretKey, required String title, required String PathBucket}) async {
    // TODO: implement getUrl
    final minio = Minio(endPoint: endPoint, accessKey: accessKey, secretKey: secretKey);
    final response = await minio.presignedGetObject(PathBucket, title, expires: 5 * 60 * 60);
    return response;
    throw UnimplementedError();
  }
 
}
