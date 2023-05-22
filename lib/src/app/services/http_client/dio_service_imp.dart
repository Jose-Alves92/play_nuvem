// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dio/dio.dart';

import 'http_client_service.dart';



class DioServiceImp implements HttpClientService {
  String? baseUrl;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;

  DioServiceImp({
    this.baseUrl = '',
    this.headers,
    this.queryParameters,
  });
  
  get dio => Dio(
      BaseOptions(
        baseUrl: baseUrl!,
        headers: headers,
        queryParameters: queryParameters,
      ),
    );

  @override
  FutureOr<Response<dynamic>> get(String url) async {
    var response = await dio.get(url);
    return response;
  }


}

// 