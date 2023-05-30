import 'package:minio/models.dart';
import 'package:minio/minio.dart';

import 'nuvem_repository.dart';

class NuvemRepositoryImp implements NuvemRepository {
  @override
  Future<ListObjectsResult> getListReproduction({required String endPoint, required String accessKey, required String secretKey, required String titleSearch, required String PathBucket}) async {
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
    final minio = Minio(endPoint: endPoint, accessKey: accessKey, secretKey: secretKey);
    final response = await minio.presignedGetObject(PathBucket, title, expires: 5 * 60 * 60);
    return response;
  }
 
}
