import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'models.dart';

part 'dictionary_api.g.dart';

@RestApi(baseUrl: 'https://dictionary-en-to-en-backend.herokuapp.com/api/v1/')
abstract class DictionaryApi {
  factory DictionaryApi(Dio dio, {String baseUrl}) = _DictionaryApi;

  @POST('search')
  Future<SearchResponse> search(@Body() SearchRequestData data);
}
