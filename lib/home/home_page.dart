import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/bloc/auth_bloc.dart';
import 'package:google_login/home/noticias_firebase/mis_noticias.dart';
import 'noticias_ext_api/noticias_deportes.dart';
import 'package:google_login/home/noticias_firebase/pantalla_tres.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final _titulosList = [
    "Deportes",
    "Mis noticias",
    "Crear noticia",
  ];
  final _pagesList = [
    NoticiasDeportes(),
    MisNoticias(),
    PantallaTres(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_titulosList[_currentPageIndex]}"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                SignOutAuthEvent(),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_baseball),
            label: "${_titulosList[0]}",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: "${_titulosList[1]}",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_outlined),
            label: "${_titulosList[2]}",
          ),
        ],
      ),
    );
  }
}
