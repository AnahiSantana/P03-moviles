import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_login/home/pantalla_uno.dart';
import 'package:google_login/models/articles.dart';

class PantallaDos extends StatelessWidget {
  const PantallaDos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getNoticias(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Algo saliomal :c"));
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ItemNoticia(noticia: snapshot.data[index]);
                });
          } else {
            return Center(child: Text("Cargando noticas"));
          }
        },
      ),
    );
  }
}

Future<List<Articles>> getNoticias() async {
  var noticias = await FirebaseFirestore.instance.collection('noticias').get();
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
