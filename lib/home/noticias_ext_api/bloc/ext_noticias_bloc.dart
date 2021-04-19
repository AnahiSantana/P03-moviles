import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/consts.dart';
import 'package:http/http.dart';
import 'package:hive/hive.dart';
import 'package:connectivity/connectivity.dart';

part 'ext_noticias_event.dart';
part 'ext_noticias_state.dart';

class ExtNoticiasBloc extends Bloc<ExtNoticiasEvent, ExtNoticiasState> {
  ExtNoticiasBloc() : super(ExtNoticiasInitial());
  Box _newsBox = Hive.box("Noticias");
  List<New> listaNoticias;

  @override
  Stream<ExtNoticiasState> mapEventToState(
    ExtNoticiasEvent event,
  ) async* {
    if (event is RequestApiNewsEvent) {
      yield LoadingState();

      //1) Revisar el tipo de conexión
      var connection = await (Connectivity().checkConnectivity());

      //2) Si hay conexión guardamos las noticias en hive
      if (connection == ConnectivityResult.wifi ||
          connection == ConnectivityResult.mobile) {
        listaNoticias = await _getAvailableNoticias(event.query);
        List<New> localNewsList =
            listaNoticias.map((New e) => e.copyWith(urlToImage: "")).toList();
        await _newsBox.put('articles', localNewsList);
      } else {
        //Mostrando noticias locales
        listaNoticias = List<New>.from(
          _newsBox.get("articles", defaultValue: []),
        );
      }

      yield LoadedNewsState(noticiasList: listaNoticias);

      //await _getAvailableNoticias(event.query) ?? []
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
