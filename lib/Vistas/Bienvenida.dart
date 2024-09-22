// Bienvenida.dart
import 'package:flutter/material.dart';

class Bienvenida extends StatelessWidget {
  const Bienvenida({Key? key, required this.titulo}) : super(key: key);
  final String titulo;

  @override
  Widget build(BuildContext context) {
    final appBarColor = Colors.blue[900] ?? Colors.blue; // Color del AppBar
    final primaryColor = Colors.blue[900] ?? Colors.blue; // Color primario
    final secondaryColor = Colors.white; // Color secundario

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: TextStyle(color: secondaryColor), // Texto blanco
        ),
        backgroundColor: appBarColor,
        elevation: 0, // Sin sombra
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.info,
              size: 100,
              color: primaryColor, // Color del icono
            ),
            SizedBox(height: 20.0),
            Text(
              'Información sobre la aplicación',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: primaryColor, // Color primario
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Bienvenido a ICO Aragón Social\n\n'
                  'Esta aplicación tiene como propósito proporcionar una plataforma para la interacción social '
                  'y la difusión de información relacionada con ICO Aragón. Puedes iniciar sesión para acceder a '
                  'contenidos exclusivos y participar en la comunidad. ¡Esperamos que disfrutes de tu experiencia!',
              style: TextStyle(
                fontSize: 18.0,
                color: primaryColor, // Color primario
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
