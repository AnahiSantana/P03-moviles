import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/consts.dart';
import 'package:http/http.dart';

part 'ext_noticias_event.dart';
part 'ext_noticias_state.dart';

class ExtNoticiasBloc extends Bloc<ExtNoticiasEvent, ExtNoticiasState> {
  ExtNoticiasBloc() : super(ExtNoticiasInitial());

  @override
  Stream<ExtNoticiasState> mapEventToState(
    ExtNoticiasEvent event,
  ) async* {
    if (event is RequestApiNewsEvent) {
      yield LoadingState();
      yield LoadedNewsState(
          noticiasList: await _getAvailableNoticias(event.query) ?? []);
    }
  }

  Future<List<New>> _getAvailableNoticias(String query) async {
    // utilizar variable q="$query" para buscar noticias en especifico
    // https://newsapi.org/v2/top-headlines?country=mx&category=sports&apiKey=1ca1885e579b42848523c8f06aea7180
    // Crear modelos antes
    var queryParams = {"country": "mx", "apiKey": API_KEY};

    if (query == "") {
      queryParams["category"] = "sports";
    } else {
      queryParams["q"] = query;
    }

    final _uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: 'v2/top-headlines',
      queryParameters: queryParams,
    );

    //completar request y deserializacion
    try {
      final response = await get(_uri);
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body)["articles"];
        return ((data).map((e) => New.fromJson(e))).toList();
      }
      return [];
    } catch (e) {
      //arroje un error
      throw "Ha ocurrido un error: $e";
    }
  }
}
