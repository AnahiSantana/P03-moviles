import 'package:flutter/material.dart';
import 'package:google_login/utils/news_repository.dart';

import 'item_noticia.dart';

class NoticiasDeportes extends StatelessWidget {
  const NoticiasDeportes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: NewsRepository().getAvailableNoticias("sports"),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Algo salio mal", style: TextStyle(fontSize: 32)),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ItemNoticia(
                  noticia: snapshot.data[index],
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
