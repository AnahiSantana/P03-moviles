import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_login/models/articles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'my_news_event.dart';
part 'my_news_state.dart';

class MyNewsBloc extends Bloc<MyNewsEvent, MyNewsState> {
  var _cFirestore = FirebaseFirestore.instance;
  MyNewsBloc() : super(MyNewsInitial());

  @override
  Stream<MyNewsState> mapEventToState(
    MyNewsEvent event,
  ) async* {
    if (event is RequestAllNewsEvent) {
      yield LoadingState();
      try {
        yield LoadedNewState(noticiasList: await _getNoticias());
      } catch (e) {
        yield ErrorMessageState(errorMsg: e);
      }
    }
  }

  Future<List<Articles>> _getNoticias() async {
    var noticias = await _cFirestore.collection('noticias').get();
    List<Articles> la = noticias.docs
        .map((e) => Articles(
            author: e['author'],
            title: e['title'],
            description: e['description'],
            urlToImage: e['image'],
            publishedAt: e['publishedAt'].toDate()))
        .toList();
    return la;
  }
}
