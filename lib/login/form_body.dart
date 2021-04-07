import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

class FormBody extends StatelessWidget {
  // cambiar a un solo value changed que reciba enum de login
  final ValueChanged<bool> onAnonymousLoginTap;
  final ValueChanged<bool> onGoogleLoginTap;
  final ValueChanged<bool> onFacebookLoginTap;

  FormBody({
    Key key,
    @required this.onAnonymousLoginTap,
    @required this.onGoogleLoginTap,
    @required this.onFacebookLoginTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // logo
        Container(
          color: Colors.blue,
          height: 256,
          width: 256,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset("assets/app_icon.png"),
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "BIENVENIDO",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(1, 2),
                  blurRadius: 1.0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.black,
                endIndent: 0,
                indent: 8,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Acceso con correo.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.black,
                endIndent: 8,
                indent: 0,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () => onAnonymousLoginTap(true),
                  color: Colors.black,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mask,
                        color: Colors.grey[200],
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          "Usuario anonimo",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.black,
                endIndent: 0,
                indent: 8,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Acceso rapido.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.black,
                endIndent: 8,
                indent: 0,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        // login buttons
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Expanded(
                child: FacebookAuthButton(
                  onPressed: () => onFacebookLoginTap(true),
                  text: "Iniciar con Facebook",
                  borderRadius: 18.0,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 14),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Expanded(
                child: GoogleAuthButton(
                  onPressed: () => onGoogleLoginTap(true),
                  text: "Iniciar con Google",
                  borderRadius: 18.0,
                  darkMode: false,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Al acceder se aceptan los terminos y condiciones asi como la politica de privacidad, "
            "mismos que pueden ser consultados en mipaginaweb.com.mx o en los ajustes de la aplicacion.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 10),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
