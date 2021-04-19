import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/login/login_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_login/models/new.dart';

import 'bloc/auth_bloc.dart';
import 'home/home_page.dart';
import 'splash_screen.dart';

void main() async {
  //inicializar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final _localStorage = await getExternalStorageDirectory();
  Hive
    ..init(_localStorage.path)
    ..registerAdapter(NewsAdapter());
  await Hive.openBox("Noticias");

  runApp(BlocProvider(
    create: (context) => AuthBloc()..add(VerifyAuthEvent()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AlreadyAuthState) return HomePage();
          if (state is UnAuthState) return LoginPage();
          return SplashScreen();
        },
      ),
    );
  }
}
