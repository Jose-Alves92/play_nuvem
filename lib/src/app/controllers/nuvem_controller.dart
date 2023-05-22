import 'package:flutter/material.dart';

import 'package:minio/models.dart';

import '../models/nuvem_model.dart';
import '../models/reproduction_items.dart';
import '../repositories/media_repository.dart';
import '../repositories/media_repository_imp.dart';
import '../repositories/nuvem_repository.dart';
import '../repositories/nuvem_repository_imp.dart';



class NuvemController with ChangeNotifier {
  final MediaRepository _midiaRepository = MediaRepositoryImp();
  final NuvemRepository _nuvemRepository= NuvemRepositoryImp();
  final List<ReproductionItems> _listReproductionItems = [];
  String _url = '';
  String _imdbId = '';
  final List<NuvemModel> _listNuvem = [
    NuvemModel(
        tipo: 'Storj',
        name: 'Nuvem1',
        credenciais: Credentials(
            endPoint: 'gateway.storjshare.io',
            accessKey: const String.fromEnvironment('ACCESSKEY_STORJ'),
            secretKey: const String.fromEnvironment('SECRETKEY_STORJ'),
            ),
        pathBucketMovies: 'demo-bucket',
        pathBucketTvShows: 'demo-bucket',
        id: '12345',
        totalcountitems: '0'),
    //Random(10).nextDouble().toString()
  ];
  List<String> listateste = [
    'https://edisciplinas.usp.br/pluginfile.php/5196097/mod_resource/content/1/Teste.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

  String get url {
    return _url;
  }

  String get imdbId {
    return _imdbId;
  }
  List<ReproductionItems> get listReproductionItems {
    return _listReproductionItems;
  }
  List<NuvemModel> get listNuvem {
    return _listNuvem;
  }

  void updateUrl({int? index = 0}) {
      _url = listReproductionItems[index!].url; //listateste[index!];
      notifyListeners();
    }

  Future<void> loadMovies(String imdbId) async {
    try {
      _listReproductionItems.clear();
      await fetchListReproduction(imdbId, 'movie');
      
      notifyListeners();
    } catch (error, StackTrace) {
      print("Exception occured: $error by $StackTrace");
    }
  }

  Future<void> loadTvShows(String tvId) async {
    try {
      _listReproductionItems.clear();
      _imdbId = await _midiaRepository.getImdb(tvId, 'tv');
      await fetchListReproduction('${_imdbId}_S01_E01', 'tv');
      
      notifyListeners();
    } catch (error, StackTrace) {
      print("Exception occured: $error by $StackTrace");
    }
  }

  Future<void> updateTvShows(String episode) async {
    try {
      _listReproductionItems.clear();
      await fetchListReproduction('$_imdbId$episode', 'tv');
      
      notifyListeners();
    } catch (error, StackTrace) {
      print("Exception occured: $error by $StackTrace");
    }
  }

  Future<void> fetchListReproduction(String titleSearch, String midiaType) async {
    for (var list in listNuvem) {
      ListObjectsResult lista = await _nuvemRepository.getListReproduction(
        endPoint: list.credenciais.endPoint,
        accessKey: list.credenciais.accessKey,
        secretKey: list.credenciais.secretKey,
        titleSearch: titleSearch,
        PathBucket: midiaType == 'movie' ? list.pathBucketMovies! : list.pathBucketTvShows!,
      );

      if(lista.objects.length > 1) {
        for(var i = 0; i <= lista.objects.length; i++) {
        List<String> separated = lista.objects[i].key!.split('_'); 
        
        // tt0944947_nomedoarquivo_2011_A+EN+PT_R720p.mp4
        String url = await _nuvemRepository.getUrl(
          endPoint: list.credenciais.endPoint, 
          accessKey: list.credenciais.accessKey, 
          secretKey: list.credenciais.secretKey, 
          title: lista.objects[i].key!, 
          PathBucket: midiaType == 'movie' ? list.pathBucketMovies! : list.pathBucketTvShows!,
          ); 
          
        _listReproductionItems.add(
          ReproductionItems(
            tipoNuvem: list.tipo,
            nameNuvem: list.name,
            title: lista.objects[i].key!,
            resolution: separated[4].substring(1, 6),
            url: url,
          ),
        );
        }
      } else if(lista.objects.length == 1) {
         List<String> separated = lista.objects[0].key!.split('_'); 
        // tt0944947_nomedoarquivo_2011_A+EN+PT_R720p.mp4
        String url = await _nuvemRepository.getUrl(
          endPoint: list.credenciais.endPoint, 
          accessKey: list.credenciais.accessKey, 
          secretKey: list.credenciais.secretKey, 
          title: lista.objects[0].key!, 
          PathBucket: midiaType == 'movie' ? list.pathBucketMovies! : list.pathBucketTvShows!,
          );  
            
        _listReproductionItems.add(
          ReproductionItems(
            tipoNuvem: list.tipo,
            nameNuvem: list.name,
            title: lista.objects[0].key!,
            resolution: separated[4].substring(1, 6),
            url: url,
          ),
        );
      } else {
        
      }
    }
  }
  
}
