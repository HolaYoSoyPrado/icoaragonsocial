// Registro.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart'; // Importamos la pantalla de inicio de sesión

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  bool _showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController =
      TextEditingController(); // Nuevo controlador para el nombre de usuario

  Future<void> _registrarUsuario(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String username = usernameController.text; // Obtener el nombre de usuario

    try {
      print("Intentando registrar usuario...");
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Usuario registrado: ${userCredential.user!.uid}");

      // Guardar el nombre de usuario en Firestore
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'correo': email,
        'nombre_usuario': username, // Guardar el nombre de usuario en Firestore
      });
      print("Datos guardados en Firestore");

      // Registro exitoso, navegar a la pantalla de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login(
                titulo:
                    'Iniciar Sesión')), // Asegúrate de pasar el título adecuado aquí si lo necesitas
      );
    } on FirebaseAuthException catch (e) {
      // Manejar errores de autenticación
      String errorMessage = 'Error al registrar usuario';
      if (e.code == 'weak-password') {
        errorMessage = 'La contraseña es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'El correo electrónico ya está en uso';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'El correo electrónico no es válido';
      }
      print("Error de FirebaseAuth: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    } catch (e) {
      // Manejar otros errores
      print("Error inesperado: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error inesperado: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.blue[900] ?? Colors.blue; // Color primario
    final secondaryColor = Colors.white; // Color secundario

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear cuenta nueva'),
        backgroundColor: primaryColor, // Color del AppBar
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person_add,
              size: 100,
              color: primaryColor, // Color del icono
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller:
                  usernameController, // Asignar el controlador para el campo de nombre de usuario
              decoration: InputDecoration(
                labelText:
                    'Nombre de usuario', // Etiqueta para el campo de nombre de usuario
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              obscureText:
                  !_showPassword, // Ocultar la contraseña si _showPassword es false
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _registrarUsuario(context);
              },
              child: Text(
                'Registrarse',
                style: TextStyle(color: secondaryColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // Color del botón
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
