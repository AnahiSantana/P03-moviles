import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/models/new.dart';
//import 'package:google_login/utils/news_repository.dart';

import 'bloc/ext_noticias_bloc.dart';
import 'item_noticia.dart';

class NoticiasDeportes extends StatefulWidget {
  const NoticiasDeportes({Key key}) : super(key: key);

  @override
  _NoticiasDeportesState createState() => _NoticiasDeportesState();
}

class _NoticiasDeportesState extends State<NoticiasDeportes> {
  ExtNoticiasBloc apiBloc;
  var searchTc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        apiBloc = ExtNoticiasBloc();
        apiBloc..add(RequestApiNewsEvent(query: ''));
        return apiBloc;
      },
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: TextField(
              controller: searchTc,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(65),
                ),
                hintText: "Buscar noticias",
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.cyan[600],
                ),
                contentPadding: EdgeInsets.all(8.0),
              ),
              onSubmitted: (String query) {
                apiBloc..add(RequestApiNewsEvent(query: query));
              },
            ),
          ),
          BlocConsumer<ExtNoticiasBloc, ExtNoticiasState>(
              listener: (context, state) {
            if (state is ErrorMessageState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMsg),
                  ),
                );
            }
          }, builder: (context, state) {
            if (state is LoadedNewsState) {
              return NewsList(noticiasList: state.noticiasList);
            }
            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }),
        ],
      )),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<New> noticiasList;
  const NewsList({
    @required this.noticiasList,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: noticiasList.length == 0
          ? Center(
              child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Text(
                "No hay noticias que mostrar.",
                style: TextStyle(fontSize: 36),
                textAlign: TextAlign.center,
              ),
            ))
          : ListView.builder(
              itemCount: noticiasList.length,
              itemBuilder: (context, index) {
                return ItemNoticia(noticia: noticiasList[index]);
              },
            ),
    );
  }
}
