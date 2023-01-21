import 'package:dio/dio.dart';
import 'package:play_nuvem/services/tmdb/http_service.dart';

class DioServiceImp implements HttpService {
  final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization':
                'Bearer ${const String.fromEnvironment("TOKEN_TMDB")}',
        },
        queryParameters: {
          'api_key': const String.fromEnvironment("APIKEY_TMD"),
          'language': 'pt-BR',
        }
      ),
    );
  @override
  getDio() {
    // TODO: implement getDio
    return ;
  }

  @override
  Future<Response<dynamic>> get(String url) async {
    var response = await dio.get(url);
    return response.data;
  }


}

// 