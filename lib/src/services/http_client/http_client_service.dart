// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class HttpClientService {
 BaseOptionsHttp? baseOptionsHttp;
  HttpClientService({
    this.baseOptionsHttp,
  });

 Future<ResponseClient> get(String url);
}

class BaseOptionsHttp {
   String? baseUrl;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  BaseOptionsHttp({
    this.baseUrl,
    this.headers,
    this.queryParameters,
  });
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