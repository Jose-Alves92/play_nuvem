import 'package:minio/minio.dart';
import 'package:play_nuvem/src/shared/models/cloud_model.dart';
import 'package:play_nuvem/src/shared/models/reproduction_items.dart';

import './i_connections_clouds.dart';

class ConnectionsCloudsImp implements IConnectionsClouds {
  Minio getMinio(Cloud cloud) => Minio(
      endPoint: cloud.credenciais.endPoint,
      accessKey: cloud.credenciais.accessKey,
      secretKey: cloud.credenciais.secretKey);

  @override
  Future<List<ReproductionItems>> getAllObjectos({required List<Cloud> listCloud, required String mediaType, required String object}) async {
   List<ReproductionItems> listReproductionItems = [];
   
   if(listCloud.isNotEmpty) {
    for (var cloud in listCloud) {
        var listObjects = await getMinio(cloud).listAllObjects(
            mediaType == 'movie'
                ? cloud.pathBucketMovies!
                : cloud.pathBucketTvShows!,
            prefix: object);
       if(listObjects.objects.isNotEmpty) {
        for (var element in listObjects.objects) {
            
            List<String> separated = element.key!.split('_');

            // tt0944947_nomedoarquivo_2011_A+EN+PT_R720p.mp4
            String url = await getUrl(cloud: cloud, object: element.key!, mediaType: mediaType);

            var item = ReproductionItems(
              tipoNuvem: cloud.tipo,
              nameNuvem: cloud.name,
              title: element.key!,
              resolution: mediaType == 'movie' ? separated[4].substring(1, 5) : separated[6].substring(1, 5),
              url: url,
            );
            listReproductionItems.add(item);
          }
          } else {

          }

      }
      return listReproductionItems;
   } else {
    return listReproductionItems;
   }
   
  }

  @override
  Future<String> getUrl(
      {required Cloud cloud,
      required String object,
      required String mediaType,
      int? expires}) async {
    final response = await getMinio(cloud).presignedGetObject(
        mediaType == 'movie'
            ? cloud.pathBucketMovies!
            : cloud.pathBucketTvShows!,
        object,
        expires: expires ?? 5 * 60 * 60);
    return response;
  }
}
