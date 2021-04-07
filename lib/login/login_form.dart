import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/home/home_page.dart';

import 'bloc/login_bloc.dart';
import 'form_body.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  bool _showLoading = false;

  // @override
  // void dispose() {
  //   _loginBloc.close();
  //   super.dispose();
  // }

  void _anonymousLogIn(bool _) {
    print("anonimo");
    _loginBloc.add(LoginAnonymousEvent());
  }

  void _googleLogIn(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("google");
    _loginBloc.add(LoginWithGoogleEvent());
  }

  void _facebookLogIn(bool _) {
    // invocar al login de firebase con el bloc
    print("facebook");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // stack background image
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff0884cc),
                Color(0xff04476e),
              ],
            ),
          ),
        ),
        // form content
        SafeArea(
          child: BlocProvider(
            create: (context) {
              _loginBloc = LoginBloc();
              return _loginBloc;
            },
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  _showLoading = false;
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text("${state.error}"),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          )
                        ],
                      );
                    },
                  );
                } else if (state is LoginLoadingState) {
                  _showLoading = !_showLoading;
                }
              },
              builder: (context, state) {
                if (state is LoginSuccessState) {
                  return HomePage();
                }
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xa0FFffff),
                    ),
                    child: FormBody(
                      onFacebookLoginTap: _facebookLogIn,
                      onGoogleLoginTap: _googleLogIn,
                      onAnonymousLoginTap: _anonymousLogIn,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _showLoading ? CircularProgressIndicator() : Container(),
        ),
      ],
    );
  }
}
