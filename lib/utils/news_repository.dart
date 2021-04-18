import 'dart:convert';
import 'dart:io';

import 'package:google_login/models/new.dart';
import 'package:google_login/utils/consts.dart';
import '../models/new.dart';
import 'package:http/http.dart';

class NewsRepository {
  List<New> _noticiasList;
  static final NewsRepository _newsRepository = NewsRepository._internal();
  factory NewsRepository() {
    return _newsRepository;
  }

  NewsRepository._internal();
  Future<List<New>> getAvailableNoticias(String query) async {
    // TODO: utilizar variable q="$query" para buscar noticias en especifico
    // https://newsapi.org/v2/top-headlines?country=mx&category=sports&apiKey=1ca1885e579b42848523c8f06aea7180
    // Crear modelos antes
    final _uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: 'v2/top-headlines',
      queryParameters: {
        "country": "mx",
        "category": "sports",
        "apiKey": API_KEY
      },
    );
    // TODO: completar request y deserializacion
    try {
      final response = await get(_uri);
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList = ((data).map((e) => New.fromJson(e))).toList();
        return _noticiasList;
      }
      return [];
    } catch (e) {
      //arroje un error
      throw "Ha ocurrido un error: $e";
    }
  }
}
