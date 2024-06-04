// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dio/dio.dart';

import 'http_client_service.dart';

class DioServiceImp implements HttpClientService {
  @override
  BaseOptionsHttp? baseOptionsHttp;
  

  DioServiceImp([this.baseOptionsHttp]);
  
  get dio => Dio(
      BaseOptions(
        baseUrl: baseOptionsHttp?.baseUrl ?? '',
        headers: baseOptionsHttp?.headers,
        queryParameters: baseOptionsHttp?.queryParameters,
      ),
    );

  @override
  Future<ResponseClient> get(String url) async {
    Response response = await dio.get(url);
    return ResponseClient(data: response.data, statusCode: response.statusCode, statusMessage: response.statusMessage);
  }

  
}



class ResponseClient {
  ResponseClient({
    this.data,
    this.statusCode,
    this.statusMessage,
   
  });

  dynamic data;
  int? statusCode;
  String? statusMessage;

}  