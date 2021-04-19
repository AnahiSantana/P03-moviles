import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ItemNoticia extends StatelessWidget {
  final New noticia;
  final urlPlaceHolder = "https://i.stack.imgur.com/y9DpT.jpg";
  ItemNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//Cambiar image.network por Extended Image con place holder en caso de error o mientras descarga la imagen
    return Container(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: (noticia.urlToImage == null || noticia.urlToImage == "")
                    ? Image.network(
                        urlPlaceHolder,
                        fit: BoxFit.fitHeight,
                        height: 100,
                      )
                    : Image.network(
                        noticia.urlToImage,
                        fit: BoxFit.fitHeight,
                        height: 100,
                      ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${noticia.title}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${noticia.publishedAt}",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.description ?? "Descripcion no disponible"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.author ?? "Autor no disponible"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.blue[400]),
                        onPressed: () {
                          share(noticia, context);
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void share(New noticia, context) async {
    try {
      String urlImage = noticia.urlToImage ?? urlPlaceHolder;
      var url = await get(Uri.parse(urlImage));
      String path = urlImage.split(".").last.split('?').first;
      Directory temp = await getTemporaryDirectory();
      File imageFile = File('${temp.path}/${noticia.title ?? "exmaple"}.$path');
      imageFile.writeAsBytesSync(url.bodyBytes);

      Share.shareFiles(
        ['${temp.path}/${noticia.title ?? "noticia"}.$path'],
        text:
            '${FirebaseAuth.instance.currentUser.displayName}: \n !Mira esta increible noticia! \n ${noticia.title ?? "Título"} \n ${noticia.url ?? ""}',
        subject:
            '${FirebaseAuth.instance.currentUser.displayName} le comparte una noticia',
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Ha ocurrido un error al compartir."),
          ),
        );
    }
  }
}
