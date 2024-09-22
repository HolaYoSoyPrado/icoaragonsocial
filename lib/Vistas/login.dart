//Login.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Registro.dart'; // Importamos la pantalla de registro
import 'PantallaPrincipal.dart'; // Importamos la nueva pantalla principal

class Login extends StatelessWidget {
  const Login({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  Future<void> _iniciarSesion(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Inicio de sesión exitoso, navegar a la pantalla principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaPrincipal()),
      );
    } catch (e) {
      // Error al iniciar sesión, mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al iniciar sesión: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarColor = Colors.blue[900] ?? Colors.blue; // Color del AppBar
    final primaryColor = Colors.blue[900] ?? Colors.blue; // Color primario
    final secondaryColor = Colors.white; // Color secundario

    String email = ''; // Variable para almacenar el correo electrónico
    String password = ''; // Variable para almacenar la contraseña

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: TextStyle(color: secondaryColor), // Texto blanco
        ),
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person,
              size: 100,
              color: primaryColor,
            ),
            SizedBox(height: 40.0),
            Text(
              'ICO Aragón Social',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
                fillColor: secondaryColor,
                filled: true,
              ),
              onChanged: (value) {
                // Guardar el correo electrónico en la variable email
                email = value;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                fillColor: secondaryColor,
                filled: true,
              ),
              onChanged: (value) {
                // Guardar la contraseña en la variable password
                password = value;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Iniciar sesión con el correo electrónico y la contraseña proporcionados
                _iniciarSesion(context, email, password);
              },
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(color: secondaryColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de registro al presionar el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registro()),
                );
              },
              child: Text(
                'Crear cuenta nueva',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
