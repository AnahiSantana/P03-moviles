import 'package:flutter/material.dart';

import '../news_repository.dart';

class PantallaUno extends StatelessWidget {
  const PantallaUno({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: NewsRepository().getAvailableNoticias(""),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Algo saliomal :c"));
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(title: snapshot.data[index].title);
                });
          } else {
            return Center(child: Text("Cargando noticas"));
          }
        },
      ),
    );
  }
}
