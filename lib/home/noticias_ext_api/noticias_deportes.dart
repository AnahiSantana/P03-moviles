import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:google_login/utils/news_repository.dart';

import 'bloc/ext_noticias_bloc.dart';
import 'item_noticia.dart';

class NoticiasDeportes extends StatefulWidget {
  const NoticiasDeportes({Key key}) : super(key: key);

  @override
  _NoticiasDeportesState createState() => _NoticiasDeportesState();
}

class _NoticiasDeportesState extends State<NoticiasDeportes> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExtNoticiasBloc()..add(RequestApiNewsEvent(query: 'sport')),
      child: BlocConsumer<ExtNoticiasBloc, ExtNoticiasState>(
        listener: (context, state) {
          if (state is LoadingState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Cargando..."),
                ),
              );
          } else if (state is ErrorMessageState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("${state.errorMsg}"),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is LoadedNewsState) {
            return ListView.builder(
              itemCount: state.noticiasList.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemNoticia(noticia: state.noticiasList[index]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
