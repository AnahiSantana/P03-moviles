import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/bloc/auth_bloc.dart';
import 'package:google_login/home/noticias_firebase/mis_noticias.dart';
import 'package:google_login/home/noticias_firebase/pantalla_tres.dart';
import 'package:google_login/home/noticias_externas/pantalla_uno.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final _pagesList = [
    PantallaUno(),
    MisNoticias(),
    PantallaTres(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                //logout
                BlocProvider.of<AuthBloc>(context).add(SignOutAuthEvent());
              }),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball),
              label: "Deportes",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded), label: "Mis noticias"),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add_outlined),
              label: "Crear",
            ),
          ]),
    );
  }
}
