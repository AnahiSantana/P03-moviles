import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleNoticia extends StatelessWidget {
  final New noticia;
  const DetalleNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticia"),
        actions: [
          IconButton(
              icon: Icon(Icons.public_rounded),
              onPressed: () async {
                if (noticia.url != null) {
                  launch(noticia.url,
                      enableJavaScript: true,
                      forceWebView: true,
                      enableDomStorage: true);
                } else {
                  launch("google.com",
                      enableJavaScript: true,
                      forceWebView: true,
                      enableDomStorage: true);
                }
              })
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(noticia.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          ),
          (noticia.urlToImage == null || noticia.urlToImage == "")
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/test-image.png',
                    fit: BoxFit.fitWidth,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    noticia.urlToImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 26, 8, 8),
            child: Text(
              "${noticia.description}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 26, 8, 8),
            child: Text(
              "${noticia.url}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
